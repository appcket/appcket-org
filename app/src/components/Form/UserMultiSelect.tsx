import { MultiSelect, Skeleton } from '@mantine/core';
import { useSearchUsers } from 'src/hooks/useUser';
import * as m from 'src/paraglide/messages';

interface UserMultiSelectProps {
  organizationId: string;
  value: string[];
  onChange: (value: string[]) => void;
  onBlur?: () => void;
  error?: React.ReactNode;
  disabled?: boolean;
}

export function UserMultiSelect({
  organizationId,
  value,
  onChange,
  onBlur,
  error,
  disabled,
}: UserMultiSelectProps) {
  const { data: users, isLoading } = useSearchUsers(organizationId);

  const userOptions = (users || []).map((user) => ({
    value: user.id,
    label: `${user.firstName} ${user.lastName} (${user.username})`,
  }));

  if (isLoading && organizationId) {
    return <Skeleton height={40} mt="md" />;
  }

  return (
    <MultiSelect
      label={m.labels_users()}
      placeholder={
        organizationId ? m.labels_users() : 'Select an organization first'
      }
      data={userOptions}
      searchable
      disabled={disabled || !organizationId}
      nothingFoundMessage="No users found"
      value={value}
      error={error}
      onBlur={onBlur}
      onChange={onChange}
      mt="md"
    />
  );
}
