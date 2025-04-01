// i18n.js

import i18n from "i18next";
import { initReactI18next } from "react-i18next";

import enTranslations from "./locales/en/translation.json";
import bgTranslations from "./locales/bg/translation.json";

const resources = {
  en: {
    translation: enTranslations
  },
  bg: {
    translation: bgTranslations
  }
};

i18n
  .use(initReactI18next)
  .init({
    resources,
    lng: "en",

    keySeparator: false,

    interpolation: {
      escapeValue: false
    }
  });

export default i18n;
