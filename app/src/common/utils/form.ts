export const resourcesToSelectMenuOptions = <T>(
  resources: T[],
  idName: keyof T,
  labelName: keyof T,
) => {
  return resources.map((resource) => {
    return {
      id: resource[idName],
      label: resource[labelName],
    };
  });
};
