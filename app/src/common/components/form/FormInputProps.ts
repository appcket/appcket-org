export interface FormSelectMenuOption {
  label: string;
  id: string;
}

export interface FormInputProps {
  name: string;
  className?: string;
  control: any;
  label: string;
  rules?: any;
  value?: any;
  setValue?: any;
  options?: FormSelectMenuOption[];
  multiline?: boolean;
  rows?: number;
}
