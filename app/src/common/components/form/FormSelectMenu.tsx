import React from 'react';
import { Controller } from 'react-hook-form';
import TextField from '@mui/material/TextField';
import MenuItem from '@mui/material/MenuItem';
import { FormInputProps } from 'src/common/components/form/FormInputProps';

export const FormSelectMenu = ({ name, control, label, rules, options }: FormInputProps) => {
  return (
    <Controller
      name={name}
      control={control}
      rules={rules}
      render={({ field: { onBlur, onChange, value }, fieldState: { error } }) => (
        <TextField
          helperText={error ? error.message : null}
          size="small"
          select
          error={!!error}
          onChange={onChange}
          onBlur={onBlur}
          value={value}
          fullWidth
          label={label}
          variant="outlined"
        >
          {options?.map((option) => (
            <MenuItem key={option.value} value={option.value}>
              {option.label}
            </MenuItem>
          ))}
        </TextField>
      )}
    />
  );
};

export default FormSelectMenu;
