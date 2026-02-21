"use client";

import Link from "next/link";
import { useTranslations } from "next-intl";
import { Separator } from "@/components/ui/separator";
import { LanguageSwitcher } from "./LanguageSwitcher";
import { ThemeSwitcher } from "./ThemeSwitcher";

/**
 * Footer component displaying copyright, language switcher, and policy links.
 *
 * @returns {JSX.Element} The rendered Footer component.
 */
export function Footer() {
  const t = useTranslations("Footer");

  const links = [
    { key: "privacyPolicy", href: "/privacy" },
    { key: "termsOfService", href: "/tos" },
  ];

  return (
    <footer className="py-8 max-w-6xl mx-auto w-full">
      <Separator />
      <div className="container mx-auto px-8 py-4 max-w-5xl">
        <div className="flex flex-col sm:flex-row justify-between items-center gap-4 text-sm text-muted-foreground">
          <p className="sm:order-first">
            © {new Date().getFullYear()} {t("copyright")}
          </p>
          <div className="flex items-center gap-6 order-first sm:order-last">
            <nav className="flex gap-6">
              {links.map((link) => (
                <Link key={link.key} href={link.href} className="hover:text-foreground transition-colors">
                  {t(link.key)}
                </Link>
              ))}
            </nav>
            <ThemeSwitcher />
            <LanguageSwitcher />
          </div>
        </div>
      </div>
    </footer>
  );
}
