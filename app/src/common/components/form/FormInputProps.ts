export interface FormSelectMenuOption {
  label: string;
  value: string;
}

export interface FormInputProps {
  name: string;
  control: any;
  label: string;
  rules?: any;
  setValue?: any;
  options?: FormSelectMenuOption[];
}
