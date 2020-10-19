#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#pragma warning(disable:4996)
void member();
void staff();
void food();
void order(char sName[]);
void payment();
void title();
void login(char *sName[]);
typedef struct {
	char staffID[6];
	char name[30];
	char position[20];
	int password;
	double salary;
}Staff;
void main() {
	int selection;
	char sName[6];
	login(&sName);
	title();
	do {	
		system("cls");
		title();
		printf("MAIN MENU\n==========\n1. Member\n2. Staff\n3. Food\n4. Order\n5. Payment\n6. Exit\n\nPlease enter your choice :");
		scanf("%d", &selection);
		rewind(stdin);
		while (selection < 1 || selection > 6) {
			printf("Invalid option! Please enter again : ");
			scanf("%d", &selection);
			rewind(stdin);
		}
		system("cls");
		switch (selection) {
		case 1:
			member();
			break;
		case 2:
			staff();
			break;
		case 3:
			food();
			break;
		case 4:
			order(sName);
			break;
		case 5:
			payment();
			break;
		case 6:
			exit(-1);
		}
	} while (selection != 6);
	order(sName);	system("pause");
}
void title() {
	printf("****************************\n");
	printf("* KFC Food Ordering System *\n");
	printf("****************************\n\n");
}
void login(char *sName[]) {
	FILE *fStaff;
	Staff s[20];
	int sNum;
	char sID[6];
	int password;
	int found, i, pCount = 0, count;
	fStaff = fopen("staff.bin", "rb");
	while (fread(&s[pCount], sizeof(Staff), 1, fStaff) != 0)
		pCount++;
	fclose(fStaff);
	printf("Login\n=====\n");
	printf("Enter Staff ID : S");
	do {
		found = 0;
		scanf("%4d", &sNum);
		rewind(stdin);
		sprintf(sID, "%c%d", 'S', sNum);
		for (i = 0; i < pCount; i++) {
			if (strcmp(sID, s[i].staffID) == 0) {
				found = 1;
				strcpy(sName, s[i].name);
				break;
				}
			}
			if (!found)
				printf("Invalid ID! Please enter again : S");
			else {
				printf("Enter your password : ");
				scanf("%d", &password);
				rewind(stdin);
				count = 0;
				while (password != s[i].password) {
					printf("\nInvalid password! %d(s) more times\nPlease enter again : ", 3-count);
					scanf("%d", &password);
					rewind(stdin);
					count++;

					if (count > 2) {
						printf("\n\nInvalid Entrance! Please find administrator.\n\n");
						system("pause");
						exit(-1);
					}
			}
		}
	} while (found == 0);
}