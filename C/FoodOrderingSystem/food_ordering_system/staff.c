#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#pragma warning (disable:4996)
void staff();
void addStaff();
void searchStaff();
void modifyStaff();
void displayStaff();
void deleteStaff();
typedef struct {
	char staffID[6];
	char name[30];
	char position[20];
	int password;
	double salary;
}Staff;

void staff()
{
	int choice;
	do {
		printf("STAFF\n=====\n");
		choose(&choice);
		switch (choice) {
		case 1: addStaff();
			break;
		case 2: searchStaff();
			break;
		case 3: modifyStaff();
			break;
		case 4: displayStaff();
			break;
		case 5: deleteStaff();
			break;
		case 6:
			break;
		}
	} while (choice != 6);
}

void addStaff()
{
	Staff list;
	FILE*fp;
	char cont;
	fp = fopen("staff.bin", "ab");
	printf("Add Staff\n=========");
	do {
		printf("\nEnter staff ID:");
		rewind(stdin);
		scanf("%s", &list.staffID);
		printf("Enter staff name:");
		rewind(stdin);
		scanf("%[^\n]", list.name);
		printf("Enter staff position:");
		rewind(stdin);
		scanf("%[^\n]", list.position);
		printf("Enter staff password:");
		rewind(stdin);
		scanf("%d", &list.password);
		printf("Enter staff salary:");
		rewind(stdin);
		scanf("%lf", &list.salary);
		fwrite(&list, sizeof(Staff), 1, fp);
		printf("More records to add? (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
	} while (toupper(cont) == 'Y');
	fclose(fp);
}

void searchStaff()
{
	char staffID[6], ans, cont;
	int i = 0, pCount = 0, found;
	Staff list[30];
	FILE*fp;
	fp = fopen("staff.bin", "rb");
	//read from file and store into structure
	while (fread(&list[pCount], sizeof(Staff), 1, fp) != 0) {
		pCount++;//indicate how many records in the file
	}
	fclose(fp);

	printf("Search Staff\n============");
	do {
		printf("\nSearch staff ID :");
		rewind(stdin);
		scanf("%s", &staffID);
		found = 0;
		printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
		printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
		for (i = 0; i < pCount; i++) {
			if (strcmp(staffID, list[i].staffID) == 0) {
				found = 1;
				printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
			}
		}
		if (!found)
			printf("\n%s staff ID could not found!\n", staffID);
		printf("\nDo you want to search again?\n (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
		system("cls");
	} while (toupper(cont) == 'Y');
	fclose(fp);
}

void displayStaff()
{
	Staff list;
	FILE*fp;
	fp = fopen("staff.bin", "rb");
	printf("Display Staff\n=============");
	printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
	printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
	while (fread(&list, sizeof(Staff), 1, fp) != 0) {
		printf("%-10s%-25s%-20s%-10d%15.2f\n", list.staffID, list.name, list.position, list.password, list.salary);
	}
	fclose(fp);
}

void modifyStaff()
{
	int modify, updPassword, i = 0, pCount = 0, found;
	double updSalary;
	char staffID[6], ans, cont, updName[30], updPosition[40];
	Staff list[30];
	FILE*fp;
	fp = fopen("staff.bin", "rb");
	//read from file and store into structure
	while (fread(&list[pCount], sizeof(Staff), 1, fp) != 0) {
		pCount++;//indicate how many records in the file
	}
	fclose(fp);

	printf("Modify Staff\n============");
	do {
		printf("\nEnter staff ID to be modified:");
		rewind(stdin);
		scanf("%s", &staffID);
		found = 0;
		printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
		printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
		for (i = 0; i < pCount; i++) {
			if (strcmp(staffID, list[i].staffID) == 0) {
				found = 1;
				printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
				printf("\nModify selection:\n");
				printf("-------------------\n");
				printf("1.Name\n");
				printf("2.Position\n");
				printf("3.Password\n");
				printf("4.Salary\n");
				printf("select (1/2/3/4) to modify :");
				do {
					rewind(stdin);
					scanf("%d", &modify);
					switch (modify) {
					case 1:
						printf("\nEnter new staff name:");
						rewind(stdin);
						scanf("%[^\n]", &updName);
						printf("comfirm to modify?(Y/N):");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y') {
							strcpy(list[i].staffID, staffID);
							strcpy(list[i].name, updName);
						}
						printf("\nUpdated record :\n ");
						printf("------------------\n");
						printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
						printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
						printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
						break;

					case 2:
						printf("Enter new staff position:");
						rewind(stdin);
						scanf("%[^\n]", &updPosition);
						printf("comfirm to modify?(Y/N) :");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y') {
							strcpy(list[i].staffID, staffID);
							strcpy(list[i].position, updPosition);
						}
						printf("\nUpdated record :\n ");
						printf("-------------------\n");
						printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
						printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
						printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
						break;

					case 3:
						printf("Enter new staff password:");
						rewind(stdin);
						scanf("%d", &updPassword);
						printf("comfirm to modify?(Y/N):");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y') {
							strcpy(list[i].staffID, staffID);
							list[i].password = updPassword;
						}
						printf("\nUpdated record :\n ");
						printf("------------------\n");
						printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
						printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
						printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
						break;

					case 4:
						printf("Enter new staff salary:");
						rewind(stdin);
						scanf("%lf", &updSalary);
						printf("comfirm to modify?(Y/N):");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y') {
							strcpy(list[i].staffID, staffID);
							list[i].salary = updSalary;
						}
						printf("\nUpdated record :\n ");
						printf("------------------\n");
						printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
						printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
						printf("%-10s%-25s%-20s%-10d%15.2f\n", list[i].staffID, list[i].name, list[i].position, list[i].password, list[i].salary);
						break;

					default:
						printf("Invalid option! Please enter again:");
					}
				} while (modify != 1 && modify != 2 && modify != 3 && modify != 4);
			}
		}
		if (!found)
			printf("\n%s staff ID not found!\n", staffID);
		printf("\nMore record to modified \n (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
		system("cls");
	} while (toupper(cont) == 'Y');
	//to save the modified record back to binary file
	fp = fopen("staff.bin", "wb");
	for (i = 0; i < pCount; i++)
		fwrite(&list[i], sizeof(Staff), 1, fp);
	fclose(fp);
}

void deleteStaff()
{
	char ans, staffID[6];
	int found = 0;
	Staff list;
	FILE*fp, *temp;
	fp = fopen("staff.bin", "rb");
	temp = fopen("temp.bin", "wb");
	printf("Delete Food\n===========");
	printf("\nEnter the staff ID to be delected:");
	scanf("%s", &staffID);
	printf("\n%-10s%10s%23s%18s%18s\n", "Staff ID", "Staff name", "Position", "Password", "Salary");
	printf("%-10s%10s%23s%20s%18s\n", "=======", "==========", "=========", "==========", "========");
	while (fread(&list, sizeof(Staff), 1, fp) != 0) {
		if (strcmp(staffID, list.staffID) == 0) {
			printf("%-10s%-25s%-20s%-10d%15.2f\n", list.staffID, list.name, list.position, list.password, list.salary);
			found = 1;
		}
		else
			fwrite(&list, sizeof(Staff), 1, temp);
	}
	fclose(fp);
	fclose(temp);
	if (found == 1) {
		printf("Are u sure to delete (Y/N):");
		rewind(stdin);
		scanf("%c", &ans);
		if (toupper(ans) == 'Y') {
			system("del staff.bin");
			system("rename temp.bin staff.bin");
			printf("\ndeleted succesfully!!!\n\n");
		}
		if (toupper(ans) != 'Y') {
			system("del temp.bin");
		}
	}
}