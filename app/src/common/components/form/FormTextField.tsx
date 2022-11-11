import { Controller } from 'react-hook-form';
import TextField from '@mui/material/TextField';
import { FormInputProps } from './FormInputProps';

export const FormTextField = ({
  name,
  className,
  control,
  label,
  multiline = false,
  rows = 4,
  rules,
}: FormInputProps) => {
  return (
    <Controller
      name={name}
      control={control}
      rules={rules}
      render={({ field: { onBlur, onChange, value }, fieldState: { error } }) => (
        <TextField
          className={className}
          helperText={error ? error.message : null}
          size="small"
          error={!!error}
          onChange={onChange}
          onBlur={onBlur}
          value={value}
          fullWidth
          label={label}
          multiline={multiline}
          rows={rows}
          variant="outlined"
        />
      )}
    />
  );
};
