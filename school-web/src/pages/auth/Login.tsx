import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useLocation, Redirect } from "wouter";
import { useTranslation } from "react-i18next";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAuth } from "@/lib/auth";
import { Input } from "@/components/ui/input";
import { CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { GraduationCap, Loader2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1, "Password is required")
});
export default function Login() {
  const {
    t
  } = useTranslation();
  const {
    login,
    user
  } = useAuth();
  const [, setLocation] = useLocation();
  const {
    toast
  } = useToast();
  const [isLoading, setIsLoading] = useState(false);
  const form = useForm<z.infer<typeof loginSchema>>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: "",
      password: ""
    }
  });
  if (user) {
    return <Redirect to={`/${user.role}`} />;
  }
  async function onSubmit(values: z.infer<typeof loginSchema>) {
    setIsLoading(true);
    try {
      const user = await login(values.email, values.password);
      setLocation(`/${user.role}`);
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: "Login failed",
        description: err.message || t("login.invalidCredentials")
      });
    } finally {
      setIsLoading(false);
    }
  }
  return <div className="min-h-screen flex items-center justify-center bg-muted/30 p-4">
      <div className="w-full max-w-md space-y-8">
        <div className="flex flex-col items-center space-y-2 text-center">
          <div className="rounded-full bg-primary/10 p-3">
            <GraduationCap className="h-8 w-8 text-primary" />
          </div>
          <h1 className="text-3xl font-bold tracking-tight">{t("common.appName")}</h1>
          <p className="text-muted-foreground">{t("login.subtitle")}</p>
        </div>

        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader>
            <CardTitle>{t("login.title")}</CardTitle>
            <CardDescription>{t("login.needHelp")}</CardDescription>
          </CardHeader>
          <CardContent>
            <Form {...form}>
              <form onSubmit={(event) => void form.handleSubmit(onSubmit)(event)} className="space-y-4">
                <FormField control={form.control} name="email" render={({
                field
              }) => <FormItem>
                      <FormLabel>{t("login.email")}</FormLabel>
                      <FormControl>
                        <Input placeholder="name@example.com" {...field} disabled={isLoading} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>} />
                <FormField control={form.control} name="password" render={({
                field
              }) => <FormItem>
                      <FormLabel>{t("login.password")}</FormLabel>
                      <FormControl>
                        <Input type="password" {...field} disabled={isLoading} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>} />
                <BrandButton type="submit" className="w-full" disabled={isLoading}>
                  {isLoading && <Loader2 className="me-2 h-4 w-4 animate-spin" />}
                  {t("login.signIn")}
                </BrandButton>
              </form>
            </Form>
          </CardContent>
          <CardFooter className="flex flex-col text-sm text-muted-foreground">
            <p className="mb-2 text-center">{t("login.demoAccounts")}</p>
            <div className="grid grid-cols-2 gap-x-4 gap-y-1 w-full text-xs">
              <span>admin@school.test</span>
              <span>finance@school.test</span>
              <span>hr@school.test</span>
              <span>teacher1@school.test</span>
              <span>parent1@school.test</span>
              <span>ali1@school.test</span>
            </div>
          </CardFooter>
        </BrandCard>
      </div>
    </div>;
}
