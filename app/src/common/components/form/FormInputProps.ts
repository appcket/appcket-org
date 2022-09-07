export interface FormSelectMenuOption {
  label: string;
  value: string;
}

export interface FormInputProps {
  name: string;
  className?: string | string[] | null;
  control: any;
  label: string;
  rules?: any;
  setValue?: any;
  options?: FormSelectMenuOption[];
}
