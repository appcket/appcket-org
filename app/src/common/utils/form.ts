export const resourcesToSelectMenuOptions = <T>(
  resources: T[],
  valueName: keyof T,
  labelName: keyof T,
) => {
  return resources.map((resource) => {
    return {
      value: resource[valueName],
      label: resource[labelName],
    };
  });
};
