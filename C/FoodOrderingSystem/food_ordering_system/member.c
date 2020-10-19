#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#pragma warning (disable:4996)

typedef struct {
	char memberID[6];
	int contactNumber;
	char name[15];
	char gender;
}Member;

void searchMember() {
	char ans;
	char memberID[6];
	int i = 0, count = 0, found;
	Member p[20];
	FILE *fp;
	fp = fopen("member.txt", "r");

	//read from file and store into array of structure
	while (fscanf(fp, "%[^\:]:%[^\:]:%d:%c\n", &p[i].memberID, &p[i].name, &p[i].contactNumber, &p[i].gender) != EOF)
		i++;

	count = i;//indicate how many records in the file
	fclose(fp);

	do {
		found = 0;
		printf("Please enter your memberID : ");
		rewind(stdin);
		scanf("%s", &memberID);


		for (i = 0; i < count; i++)
			if (strcmp(memberID, p[i].memberID) == 0) {
				found = 1;
				printf("\n\n%-10s%-20s%-13s%-6s\n", "Member ID", "Name", "Contact No", "Gender");
				printf("%-10s%-20s%-13s%-6s\n", "=========", "====", "==========", "======");
				printf("%-10s%-20s%-15d%-6c\n", p[i].memberID, p[i].name, p[i].contactNumber, p[i].gender);
			}
		if (!found)
			printf("Member %s is not be found\n", memberID);
		printf("More to search (Y/N) ? ");
		rewind(stdin);
		scanf("%c", &ans);
	} while (toupper(ans) == 'Y');
}

void modifyMember() {  // declaration

	char ans, cont, gender;
	char memberID[6], name[15];
	int contactNumber;
	int i = 0, updYear, modiCount = 0;
	int pcount, found;

	Member p[20];
	FILE *fp;

	fp = fopen("member.txt", "r");

	//read from file and store into array of structure
	while (fscanf(fp, "%[^\:]:%[^\:]:%d:%c\n", &p[i].memberID, &p[i].name, &p[i].contactNumber, &p[i].gender) != EOF)
		i++;

	pcount = i;//indicate how many records in the file
	fclose(fp);

	do {
		printf("Enter memberID to be modified : ");
		rewind(stdin);
		scanf("%s", &memberID);
		found = 0;
		for (i = 0; i < pcount; i++)
		{
			if (strcmp(memberID, p[i].memberID) == 0) {
				found = 1;
				printf("%-10s%-20s%-13s%-6s\n", "Member ID", "Name", "Contact No", "Gender");
				printf("%-10s%-20s%-13s%-6s\n", "=========", "====", "==========", "======");
				printf("%-10s%-20s%-15d%-6c\n", p[i].memberID, p[i].name, p[i].contactNumber, p[i].gender);
				printf("Enter new name : ");
				rewind(stdin);
				scanf("%[^\n]", &name);
				printf("Enter new contact number : ");
				rewind(stdin);
				scanf("%d", &contactNumber);
				printf("Enter new gender : ");
				rewind(stdin);
				scanf("%c", &gender);
				printf("Confirm to modify (Y/N) ? ");
				rewind(stdin);
				scanf("%c", &ans);
				if (toupper(ans) == 'Y') {
					strcpy(p[i].name, name);
					p[i].contactNumber = contactNumber;
					p[i].gender = gender;
					modiCount++;
				}

				break;
			}
		}
		if (!found)
			printf("\nMember %s is not found !\n", memberID);
		else {
			printf("\nUpdated Record : \n");
			printf("%-10s%-20s%-13s%-6s\n", "Member ID", "Name", "Contact No", "Gender");
			printf("%-10s%-20s%-13s%-6s\n", "=========", "====", "==========", "======");
			printf("%-10s%-20s%-15d%-6c\n", p[i].memberID, p[i].name, p[i].contactNumber, p[i].gender);
		}
		printf("more record to modify(Y/N) ? ");
		rewind(stdin);
		scanf("%c", &cont);
	} while (toupper(cont) == 'Y');

	//to save the modified records back to text file
	fp = fopen("member.txt", "w");
	for (i = 0; i< pcount; i++)
		fprintf(fp, "%s:%s:%d:%c\n", p[i].memberID, p[i].name, p[i].contactNumber, p[i].gender);

	fclose(fp);
	printf("\n%d records modified.\n", modiCount);
}

void displayMember() {
	Member menu;
	FILE *fp;
	int count = 0;
	fp = fopen("member.txt", "r");
	printf("%-10s%-20s%-13s%-6s\n", "Member ID", "Name", "Contact No", "Gender");
	printf("%-10s%-20s%-13s%-6s\n", "=========", "====", "==========", "======");
	while (fscanf(fp, "%[^\:]:%[^\:]:%d:%c\n", &menu.memberID, &menu.name, &menu.contactNumber, &menu.gender) != EOF) {
		printf("%-10s%-20s%-15d%-6c\n", menu.memberID, menu.name, menu.contactNumber, menu.gender);
		count++;
	}
	printf("\n<%d record listed>\n", count);
	fclose(fp);
}
void addMember() {
	Member menu;
	FILE *fp;
	char cont;

	fp = fopen("member.txt", "a");
	do {
		printf("Enter memberID : ");
		rewind(stdin);
		scanf("%s", &menu.memberID);
		printf("Enter the name : ");
		rewind(stdin);
		scanf("%[^\n]", &menu.name);
		printf("Enter contactNumber : ");
		rewind(stdin);
		scanf("%d", &menu.contactNumber);
		printf("Enter the gender : ");
		rewind(stdin);
		scanf("%c", &menu.gender);
		fprintf(fp, "%s:%s:%d:%c\n", menu.memberID, menu.name, menu.contactNumber, menu.gender);
		printf("More records to add (Y/N) ? ");
		rewind(stdin);
		scanf("%c", &cont);
	} while (toupper(cont) == 'Y');
	fclose(fp);
}

void member() {
	int option;
	
	do {
		printf("Member Module\n");
		printf("=============\n");
		printf("1. Add\n");
		printf("2. Display\n");
		printf("3. Modify\n");
		printf("4. Search\n");
		printf("5. Exit\n");
		printf("\nEnter your option : ");
		rewind(stdin);
		scanf("%d", &option);
		memberOption(option);
	} while (option != 5);
}
int memberOption(int choice) {
	system("cls");
	switch (choice) {
	case 1:
		printf("Add Member:\n===========\n");
		addMember(); break;
	case 2:
		printf("Display Member:\n===============\n");
		displayMember();
		break;
	case 3:
		printf("Modify Member:\n==============\n");
		modifyMember(); break;
	case 4:
		printf("Search Member:\n==============\n");
		searchMember(); break;
	case 5: break;
	default:
		printf("\nInvalid option! Please enter again\n");
	}
}
