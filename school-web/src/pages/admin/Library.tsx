import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function AdminLibrary() {
  const { toast } = useToast();
  const qc = useQueryClient();

  const [tab, setTab] = useState<"books" | "borrowings" | "overdue">("books");
  const [showForm, setShowForm] = useState(false);
  const [title, setTitle] = useState("");
  const [author, setAuthor] = useState("");
  const [isbn, setIsbn] = useState("");
  const [copies, setCopies] = useState(1);
  const [category, setCategory] = useState("");

  const { data: books, isLoading: booksLoading } = useQuery({
    queryKey: ["admin-library-books"],
    queryFn: () => Admin.libraryBooks(),
    enabled: tab === "books",
  });

  const { data: borrowings, isLoading: borrowingsLoading } = useQuery({
    queryKey: ["admin-library-borrowings"],
    queryFn: () => Admin.libraryBorrowings(),
    enabled: tab === "borrowings",
  });

  const { data: overdue, isLoading: overdueLoading } = useQuery({
    queryKey: ["admin-library-overdue"],
    queryFn: () => Admin.libraryOverdue(),
    enabled: tab === "overdue",
  });

  const createMutation = useMutation({
    mutationFn: (data: any) => Admin.createLibraryBook(data),
    onSuccess: () => {
      toast({ title: "Success", description: "Book added to library." });
      setShowForm(false);
      setTitle(""); setAuthor(""); setIsbn(""); setCopies(1); setCategory("");
      void qc.invalidateQueries({ queryKey: ["admin-library-books"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to add book.", variant: "destructive" }),
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !author.trim()) return;
    createMutation.mutate({ title: title.trim(), author: author.trim(), isbn: isbn.trim() || undefined, total_copies: copies, category: category.trim() || undefined });
  };

  const booksItems = Array.isArray(books) ? books : (books as any)?.data ?? [];
  const borrowingItems = Array.isArray(borrowings) ? borrowings : (borrowings as any)?.data ?? [];
  const overdueItems = Array.isArray(overdue) ? overdue : (overdue as any)?.data ?? [];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Library Management</h1>
        <button onClick={() => setShowForm(!showForm)} className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90">
          {showForm ? "Cancel" : "+ Add Book"}
        </button>
      </div>

      {showForm && (
        <form onSubmit={handleSubmit} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Add Book</h2>
          <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Title *" value={title} onChange={(e) => setTitle(e.target.value)} />
          <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Author *" value={author} onChange={(e) => setAuthor(e.target.value)} />
          <div className="grid grid-cols-2 gap-4">
            <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="ISBN" value={isbn} onChange={(e) => setIsbn(e.target.value)} />
            <input type="number" min={1} className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Copies" value={copies} onChange={(e) => setCopies(Number(e.target.value))} />
          </div>
          <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Category" value={category} onChange={(e) => setCategory(e.target.value)} />
          <button type="submit" disabled={createMutation.isPending} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createMutation.isPending ? "Adding…" : "Add Book"}
          </button>
        </form>
      )}

      {/* Tabs */}
      <div className="flex gap-1 rounded-lg bg-muted p-1">
        {(["books", "borrowings", "overdue"] as const).map((t) => (
          <button key={t} onClick={() => setTab(t)} className={`flex-1 rounded-md px-3 py-2 text-sm font-medium transition ${tab === t ? "bg-background shadow-sm" : "hover:bg-background/50"}`}>
            {t === "books" ? "📚 Books" : t === "borrowings" ? "📖 Borrowings" : "⚠️ Overdue"}
          </button>
        ))}
      </div>

      {tab === "books" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Title</th><th className="text-left p-3">Author</th><th className="text-left p-3">ISBN</th><th className="text-center p-3">Copies</th><th className="text-center p-3">Available</th></tr></thead>
            <tbody>
              {booksLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              booksItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No books yet</td></tr> :
              booksItems.map((b: any) => (
                <tr key={b.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{b.title}</td>
                  <td className="p-3">{b.author}</td>
                  <td className="p-3 text-muted-foreground">{b.isbn ?? "—"}</td>
                  <td className="p-3 text-center">{b.total_copies ?? b.copies ?? "—"}</td>
                  <td className="p-3 text-center">{b.available_copies ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "borrowings" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Book</th><th className="text-left p-3">Borrower</th><th className="text-left p-3">Borrowed</th><th className="text-left p-3">Due</th><th className="text-center p-3">Status</th></tr></thead>
            <tbody>
              {borrowingsLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              borrowingItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No borrowings</td></tr> :
              borrowingItems.map((b: any) => (
                <tr key={b.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{b.book?.title ?? b.book_title ?? "—"}</td>
                  <td className="p-3">{b.user?.name ?? b.borrower_name ?? "—"}</td>
                  <td className="p-3">{b.borrowed_at ? new Date(b.borrowed_at).toLocaleDateString() : "—"}</td>
                  <td className="p-3">{b.due_at ? new Date(b.due_at).toLocaleDateString() : "—"}</td>
                  <td className="p-3 text-center"><span className={`px-2 py-0.5 rounded-full text-xs ${b.returned_at ? "bg-green-500/10 text-green-600" : "bg-yellow-500/10 text-yellow-600"}`}>{b.returned_at ? "Returned" : "Active"}</span></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "overdue" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Book</th><th className="text-left p-3">Borrower</th><th className="text-left p-3">Due Date</th><th className="text-center p-3">Days Overdue</th></tr></thead>
            <tbody>
              {overdueLoading ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              overdueItems.length === 0 ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">No overdue books 🎉</td></tr> :
              overdueItems.map((b: any) => (
                <tr key={b.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{b.book?.title ?? b.book_title ?? "—"}</td>
                  <td className="p-3">{b.user?.name ?? b.borrower_name ?? "—"}</td>
                  <td className="p-3 text-red-600">{b.due_at ? new Date(b.due_at).toLocaleDateString() : "—"}</td>
                  <td className="p-3 text-center font-bold text-red-600">{b.days_overdue ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
