import { Controller } from 'react-hook-form';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import { FormInputProps } from './FormInputProps';

const FormAutocomplete = ({
  name,
  className,
  control,
  label,
  rules,
  options,
  value,
}: FormInputProps) => {
  return (
    <Controller
      name={name}
      control={control}
      rules={rules}
      render={({ field: { onChange }, fieldState: { error } }) => (
        <Autocomplete
          defaultValue={value}
          isOptionEqualToValue={(option, value) => option.value === value.value}
          disablePortal
          options={options ? options : []}
          onChange={onChange}
          renderInput={(params) => (
            <TextField
              {...params}
              className={className}
              helperText={error ? error.message : null}
              size="small"
              error={!!error}
              fullWidth
              label={label}
              variant="outlined"
            />
          )}
        />
      )}
    />
  );
};

export default FormAutocomplete;
