import { Switch, useMantineColorScheme, useComputedColorScheme, rem, Box } from '@mantine/core';
import { HiOutlineSun, HiOutlineMoon } from 'react-icons/hi2';
import { useState, useEffect } from 'react';

export function ThemeToggle() {
  const { setColorScheme } = useMantineColorScheme({ keepTransitions: true });
  const computedColorScheme = useComputedColorScheme('light', { getInitialValueInEffect: true });
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const sunIcon = (
    <HiOutlineSun
      style={{ width: rem(16), height: rem(16), color: 'var(--mantine-color-appYellow-9)' }}
    />
  );

  const moonIcon = (
    <HiOutlineMoon
      style={{ width: rem(16), height: rem(16), color: 'var(--mantine-color-appSky-4)' }}
    />
  );

  // Return a placeholder or null during SSR to prevent hydration mismatch
  if (!mounted) {
    return <Box style={{ width: rem(60), height: rem(30) }} />;
  }

  return (
    <Switch
      size="md"
      color="dark.4"
      onLabel={moonIcon}
      offLabel={sunIcon}
      checked={computedColorScheme === 'dark'}
      onChange={() => setColorScheme(computedColorScheme === 'light' ? 'dark' : 'light')}
    />
  );
}
