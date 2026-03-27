import { Menu, UnstyledButton, Group, Text, rem } from '@mantine/core';
import { HiChevronDown } from 'react-icons/hi2';
import Flag from 'react-flagpack';
import 'react-flagpack/dist/style.css';
import * as runtime from 'src/paraglide/runtime';
import { setLocale } from 'src/lib/i18n';
import { useRouter } from '@tanstack/react-router';

const languageNames: Record<string, string> = {
  en: 'English (US)',
  'en-GB': 'English (UK)',
  es: 'Español',
};

const countryCodes: Record<string, string> = {
  en: 'US',
  'en-GB': 'GB-UKM',
  es: 'ES',
};

export function LanguagePicker() {
  const router = useRouter();
  const currentLanguage = runtime.getLocale();

  const handleLanguageChange = async (newLocale: string) => {
    await setLocale({ data: newLocale });
    // Reload the page or invalidate router to apply changes
    router.invalidate();
  };

  return (
    <Menu shadow="md" width={150} position="bottom-end">
      <Menu.Target>
        <UnstyledButton>
          <Group gap={5}>
            <Flag code={countryCodes[currentLanguage] || 'US'} size="s" gradient="top-down" />
            <Text size="sm" fw={500} visibleFrom="xs">
              {currentLanguage.toUpperCase()}
            </Text>
            <HiChevronDown size={rem(14)} />
          </Group>
        </UnstyledButton>
      </Menu.Target>

      <Menu.Dropdown>
        {runtime.locales.map((lang) => (
          <Menu.Item
            key={lang}
            onClick={() => handleLanguageChange(lang)}
            leftSection={<Flag code={countryCodes[lang] || 'US'} size="s" gradient="top-down" />}
          >
            {languageNames[lang] || lang}
          </Menu.Item>
        ))}
      </Menu.Dropdown>
    </Menu>
  );
}
