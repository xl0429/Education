#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#pragma warning (disable:4996)
void food();
void choose(int *option);
void addFood();
void searchFood();
void modifyFood();
void displayFood();
void deleteFood();
typedef struct {
	char foodID[6];
	char name[30];
	char description[100];
	double price;
}Food;

void food()
{
	int choice;
	do {
		printf("FOOD\n====\n");
		choose(&choice);
		switch (choice) {
		case 1: addFood();
			break;
		case 2: searchFood();
			break;
		case 3: modifyFood();
			break;
		case 4: displayFood();
			break;
		case 5: deleteFood();
			break;
		case 6: 
			break;
		}
	} while (choice != 6);
}
void choose(int *option)
{
	printf("1. Add\n");
	printf("2. Search\n");
	printf("3. Modify\n");
	printf("4. Display\n");
	printf("5. Delete\n");
	printf("6. Back to Menu\n");
	printf("Please enter your choice :");
	scanf("%d", option);
	rewind(stdin);
	system("cls");
	while (*option<1 || *option>6) {
		printf("\nInvalid option! Please enter again :");
		scanf("%d", option);
		rewind(stdin);
	}
}

void addFood()
{
	Food menu;
	FILE*fp;
	char cont;
	fp = fopen("food.bin", "ab");

	printf("Add Food\n========\n");
	do {
		printf("Enter food ID:");
		rewind(stdin);
		scanf("%s", &menu.foodID);
		printf("Enter food name:");
		rewind(stdin);
		scanf("%[^\n]", menu.name);
		printf("Enter food description:");
		rewind(stdin);
		scanf("%[^\n]", menu.description);
		printf("Enter food price:");
		rewind(stdin);
		scanf("%lf", &menu.price);
		fwrite(&menu, sizeof(Food), 1, fp);
		printf("More records to add? (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
	} while (toupper(cont) == 'Y');
	fclose(fp);
}

void searchFood()
{
	char foodID[6], ans, cont;
	int i = 0, pCount = 0, found;
	Food menu[30];
	FILE*fp;
	fp = fopen("food.bin", "rb");

	//read from file and store into structure
	while (fread(&menu[pCount], sizeof(Food), 1, fp) != 0) {
		pCount++;//indicate how many records in the file
	}
	fclose(fp);

	printf("Search Food\n===========\n");

	do {
		printf("Search food ID :");
		rewind(stdin);
		scanf("%s", &foodID);
		found = 0;
		printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
		printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");

		for (i = 0; i < pCount; i++) {
			if (strcmp(foodID, menu[i].foodID) == 0) {
				found = 1;
				printf("%-10s%-25s%-70s%8.2f\n", menu[i].foodID, menu[i].name, menu[i].description, menu[i].price);
			}
		}
		if (!found)
			printf("\n%s food ID could not found!\n", foodID);
		printf("\nDo you wan to search again?\n (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
		system("cls");
	} while (toupper(cont) == 'Y');
}

void displayFood()
{
	Food menu;
	FILE*fp;
	fp = fopen("food.bin", "rb");
	printf("\nDisplay Food\n==============\n");
	printf("%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
	printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");

	while (fread(&menu, sizeof(Food), 1, fp) != 0) {
		printf("%-10s%-25s%-70s%8.2f\n", menu.foodID, menu.name, menu.description, menu.price);
	}
	fclose(fp);
}

void modifyFood()
{
	int modify;
	double updPrice;
	char foodID[6], ans, cont, updName[30], updDescp[100];
	int i = 0;
	int pCount = 0, found;
	Food menu[30];
	FILE*fp;
	fp = fopen("food.bin", "rb");

	//read from file and store into structure
	while (fread(&menu[pCount], sizeof(Food), 1, fp) != 0) {
		pCount++;//indicate how many records in the file
	}
	fclose(fp);

	printf("Modify Food\n===========\n");
	do {
		printf("Enter food ID to be modified:");
		rewind(stdin);
		scanf("%s", &foodID);
		found = 0;
		printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
		printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");

		for (i = 0; i < pCount; i++) {
			if (strcmp(foodID, menu[i].foodID) == 0) {
				found = 1;
				printf("%-10s%-25s%-70s%8.2f\n", menu[i].foodID, menu[i].name, menu[i].description, menu[i].price);
				printf("\nModify selection:\n");
				printf("-------------------\n");
				printf("1.Name\n");
				printf("2.Description\n");
				printf("3.Price\n");
				printf("select (1/2/3) to modify :");

				do {
					rewind(stdin);
					scanf("%d", &modify);

					switch (modify) {
					case 1:
						printf("\nEnter new food name:");
						rewind(stdin);
						scanf("%[^\n]", &updName);
						printf("comfirm to modify?(Y/N):");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y')
						{
							strcpy(menu[i].foodID, foodID);
							strcpy(menu[i].name, updName);
						}
						printf("\nUpdated record :\n ");
						printf("------------------\n");
						printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
						printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");
						printf("%-10s%-25s%-70s%8.2f\n", menu[i].foodID, menu[i].name, menu[i].description, menu[i].price);
						break;

					case 2:
						printf("Enter new food description:");
						rewind(stdin);
						scanf("%[^\n]", &updDescp);
						printf("comfirm to modify?(Y/N) :");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y')
						{
							strcpy(menu[i].foodID, foodID);
							strcpy(menu[i].description, updDescp);
						}
						printf("\nUpdated record :\n ");
						printf("-------------------\n");
						printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
						printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");
						printf("%-10s%-25s%-70s%8.2f\n", menu[i].foodID, menu[i].name, menu[i].description, menu[i].price);
						break;

					case 3:
						printf("Enter new food price:");
						rewind(stdin);
						scanf("%lf", &updPrice);
						printf("comfirm to modify?(Y/N):");
						rewind(stdin);
						scanf("%c", &ans);
						if (toupper(ans) == 'Y')
						{
							strcpy(menu[i].foodID, foodID);
							menu[i].price = updPrice;
						}
						printf("\nUpdated record :\n ");
						printf("------------------\n");
						printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
						printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");
						printf("%-10s%-25s%-70s%8.2f\n", menu[i].foodID, menu[i].name, menu[i].description, menu[i].price);
						break;

					default:
						printf("Invalid option! Please enter again:");
					}
				} while (modify != 1 && modify != 2 && modify != 3);
			}
		}
		if (!found)
			printf("\n%s food ID not found!\n", foodID);
		printf("\nMore record to modified \n (Y/N):");
		rewind(stdin);
		scanf("%c", &cont);
		system("cls");
	} while (toupper(cont) == 'Y');
	//to save the modified record back to binary file
	fp = fopen("food.bin", "wb");
	for (i = 0; i < pCount; i++)
		fwrite(&menu[i], sizeof(Food), 1, fp);
	fclose(fp);
}

void deleteFood()
{
	char ans;
	int found = 0;
	char foodID[6];
	Food menu;
	FILE*fp, *temp;

	fp = fopen("food.bin", "rb");
	temp = fopen("temp.bin", "wb");
	printf("Delete Food\n===========\n");
	printf("Enter the food ID to be delected:");
	scanf("%s", &foodID);
	printf("\n%-10s%9s%27s%67s\n", "Food ID", "Food name", "Description", "Price");
	printf("%-10s%9s%25s%70s\n", "=======", "=========", "=========", "=========");
	while (fread(&menu, sizeof(Food), 1, fp) != 0) {
		if (strcmp(foodID, menu.foodID) == 0) {
			printf("%-10s%-25s%-70s%8.2f\n", menu.foodID, menu.name, menu.description, menu.price);
			found = 1;
		}
		else
			fwrite(&menu, sizeof(Food), 1, temp);
	}
	fclose(fp);
	fclose(temp);
	if (found == 1) {
		printf("Are u sure to delete (Y/N):");
		rewind(stdin);
		scanf("%c", &ans);
		if (toupper(ans) == 'Y')
		{
			system("del food.bin");
			system("rename temp.bin food.bin");
			printf("\ndeleted succesfully!!!\n\n");
		}
		if (toupper(ans) != 'Y') {
			system("del temp.bin");
		}
	}
}