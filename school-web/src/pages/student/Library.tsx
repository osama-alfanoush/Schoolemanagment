import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Student, PaginatedResponse, LibraryBook } from "@/lib/api";
import { renderDate, renderStatus } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

type Tab = "browse" | "borrowings";

export default function StudentLibrary() {
  const [tab, setTab] = useState<Tab>("browse");
  const [search, setSearch] = useState("");

  const { data: booksData, isLoading: booksLoading } = useQuery({
    queryKey: ["student-library-books", search],
    queryFn: () => Student.libraryBooks({ search }),
    enabled: tab === "browse",
  }) as any;
  const { data: borrowingsData, isLoading: borrowingsLoading } = useQuery({
    queryKey: ["student-borrowings"],
    queryFn: () => Student.myBorrowings(),
    enabled: tab === "borrowings",
  }) as any;
const books = Array.isArray(booksData) ? booksData : booksData?.data ?? [];
  const borrowings = Array.isArray(borrowingsData) ? borrowingsData : borrowingsData?.data ?? [];

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Library" subtitle="Browse books and manage your borrowings" />

      <div className="flex gap-2">
        <button
          onClick={() => setTab("browse")}
          className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
            tab === "browse" ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
          }`}
          style={tab === "browse" ? { background: "var(--gradient-main)" } : undefined}
        >
          Browse Books
        </button>
        <button
          onClick={() => setTab("borrowings")}
          className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
            tab === "borrowings" ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
          }`}
          style={tab === "borrowings" ? { background: "var(--gradient-main)" } : undefined}
        >
          My Borrowings
        </button>
      </div>

      {tab === "browse" && (
        <>
          <SearchAndFilter
            placeholder="Search books by title, author..."
            value={search}
            onChange={setSearch}
          />

          {books.length === 0 && !booksLoading ? (
            <BrandEmptyState icon="UI" title="No books found" subtitle="Try a different search term." />
          ) : booksLoading ? (
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
              {Array.from({ length: 8 }).map((_, i) => (
                <div key={i} className="rounded-2xl p-4 bg-card shadow-card animate-pulse">
                  <div className="w-full aspect-[3/4] rounded-xl mb-3 bg-muted/50" />
                  <div className="w-3/4 h-4 bg-muted/50 rounded mb-2" />
                  <div className="w-1/2 h-3 bg-muted/30 rounded" />
                </div>
              ))}
            </div>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
              {books.map((book: any) => (
                <BrandCard key={book.id} className="p-4">
                  <div className="w-full aspect-[3/4] rounded-xl mb-3 bg-gradient-to-b from-gray-100 to-gray-200 flex items-center justify-center overflow-hidden">
                    {book.cover_url ? (
                      <img src={book.cover_url} className="w-full h-full object-cover rounded-xl" alt={book.title} />
                    ) : (
                      <span className="text-4xl"></span>
                    )}
                  </div>
                  <p className="text-sm font-semibold text-foreground line-clamp-2 mb-1">{book.title}</p>
                  <p className="text-xs text-muted-foreground mb-2">{book.author}</p>
                  <div className="flex items-center justify-between">
                    {renderStatus(book.available_copies > 0 ? "in-stock" : "out-stock")}
                    <span className="text-xs text-muted-foreground/70">{book.available_copies}/{book.total_copies}</span>
                  </div>
                </BrandCard>
              ))}
            </div>
          )}
        </>
      )}

      {tab === "borrowings" && (
        <DataTable
          data={borrowings}
          isLoading={borrowingsLoading}
          columns={[
            {
              key: "book",
              label: "Book",
              render: (_: any, row: any) => (
                <div>
                  <div className="text-sm font-medium text-foreground">{row.book_title ?? row.title ?? "-"}</div>
                  <div className="text-xs text-muted-foreground/70">{row.author}</div>
                </div>
              ),
            },
            { key: "borrowed_date", label: "Borrowed", sortable: true, render: (v: any) => renderDate(v) },
            { key: "due_date", label: "Due Date", sortable: true, render: (v: any) => renderDate(v) },
            { key: "status", label: "Status", render: (v: any) => renderStatus(v) },
            {
              key: "fine",
              label: "Fine",
              render: (v: any) =>
                v && v > 0 ? <span style={{ color: "var(--color-primary)" }}>${v.toFixed(2)}</span> : <span className="text-muted-foreground/50 text-xs">-</span>,
            },
          ]}
          emptyMessage="No borrowing history"
          emptyIcon="UI"
        />
      )}
    </div>
  );
}
