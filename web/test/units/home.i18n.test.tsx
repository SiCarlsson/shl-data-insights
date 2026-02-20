import { it, vi } from "vitest";
import Home from "@/app/[locale]/page";
import svMessages from "../../messages/sv.json";
import enMessages from "../../messages/en.json";
import { NextIntlClientProvider } from "next-intl";
import { render, screen } from "@testing-library/react";
import type * as NextIntlServer from "next-intl/server";

vi.mock("next-intl/server", async (importOriginal: () => Promise<typeof NextIntlServer>) => {
  const actual = await importOriginal();
  const messages = (await import("../../messages/sv.json")).default as Record<string, Record<string, string>>;
  return {
    ...actual,
    setRequestLocale: vi.fn(),
    getTranslations: vi.fn().mockImplementation(async (opts?: { namespace?: string } | string) => {
      const namespace = typeof opts === "string" ? opts : (opts?.namespace ?? "");
      return (key: string) => messages[namespace]?.[key] ?? key;
    }),
  };
});

const makeGetTranslations = (messages: Record<string, Record<string, string>>) =>
  vi.fn().mockImplementation(async (opts?: { namespace?: string } | string) => {
    const namespace = typeof opts === "string" ? opts : (opts?.namespace ?? "");
    return (key: string) => messages[namespace]?.[key] ?? key;
  });

it("renders in Swedish", async () => {
  const ResolvedHome = await Home({ params: Promise.resolve({ locale: "sv" }) });
  render(
    <NextIntlClientProvider locale="sv" messages={svMessages}>
      {ResolvedHome}
    </NextIntlClientProvider>,
  );
  screen.getByText(svMessages.HomePage.title);
});

it("renders in English", async () => {
  const { getTranslations } = await import("next-intl/server");
  vi.mocked(getTranslations).mockImplementation(
    makeGetTranslations(enMessages as Record<string, Record<string, string>>),
  );

  const ResolvedHome = await Home({ params: Promise.resolve({ locale: "en" }) });
  render(
    <NextIntlClientProvider locale="en" messages={enMessages}>
      {ResolvedHome}
    </NextIntlClientProvider>,
  );
  screen.getByText(enMessages.HomePage.title);
});
