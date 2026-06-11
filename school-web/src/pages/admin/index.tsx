import { Switch, Route, Redirect } from "wouter";
import { AppShell } from "@/components/layout/AppShell";
import { RoleGuard } from "@/components/layout/RoleGuard";

import AdminDashboard from "@/pages/admin/Dashboard";
import AdminUsers from "@/pages/admin/Users";
// ... other imports

export default function AdminPortal() {
  return (
    <RoleGuard roles={["admin"]}>
      <AppShell>
        <Switch>
          <Route path="/admin" component={AdminDashboard} />
          <Route path="/admin/users" component={AdminUsers} />
          <Route path="/admin/*">
            <div className="p-8 text-center text-muted-foreground">Under Construction</div>
          </Route>
        </Switch>
      </AppShell>
    </RoleGuard>
  );
}
