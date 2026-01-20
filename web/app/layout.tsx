import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "SHL Data Insights",
  description: "Data insights and analytics for SHL",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
