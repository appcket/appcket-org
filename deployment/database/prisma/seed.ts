import { PrismaClient, Prisma } from '@prisma/client';

const prisma = new PrismaClient();

const organizationData: Prisma.organizationCreateInput[] = [
  {
    organization_id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
    name: 'Pennypacker Enterprises',
    created_at: new Date(),
  },
];

async function main() {
  console.log(`Start seeding ...`);

  for (const org of organizationData) {
    const organization = await prisma.organization.create({
      data: org,
    });
    console.log(`Created org with id: ${org.organization_id}`);
  }

  console.log(`Seeding finished.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
