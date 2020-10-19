#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include<Windows.h>
#define SIZE 20 //size of food ordered
#pragma warning(disable:4996)
typedef struct {
	int day, month, year, hour, min;
}Date;
typedef struct {//read price and name from food.bin
	char id[6];
	char name[30];
	char description[100];
	double price;
}Food;
typedef struct {//read member ID
	char memberID[6];
	int contactNumber;
	char name[15];
	char gender;
}Member;
typedef struct {
	char fId[6];
	char name[30];
	int qty;
	double price;// price per unit
	double amt;// price * qty
}OrDetails;
typedef struct {
	char oId[6];
	char mId[6];
	int orNum;
	OrDetails f[SIZE];
	Date d;
	double tPrice;// total price of one set order
	char sName[25];//staff name
}Order;

int orderMenu();
void addOrder(char sName[]);
void searchOrder();
void modify();
void displayOneOrder();
int validation(int input);// validation for 2 selection;
int displayOrder(int search, int temp, int *found);//display search and all order
int orderMenu();
void addPayment();
void order(char sName[]) {
	int selection;
	int search = 0, temp = 0, found = 0;
	do {
		selection = orderMenu();
		system("cls");
		switch (selection) {
		case 1:
			printf("Add Order :\n===========\n");
			addOrder(sName);
			break;
		case 2:
			printf("Search Order :\n==============\n");
			searchOrder();
			break;
		case 3:
			printf("Display Order :\n===============\n");
			displayOrder(search, temp, &found);
			system("pause");
			break;
		case 4:break;
		}
		system("cls");
	} while (selection != 4);
}
int orderMenu() {
	int selection;
	printf("ORDER\n=====\n");
	printf("1. Add\n2. Search\n3. Display\n4. Back To Menu\n\nPlease enter your choice : ");
	scanf("%d", &selection);
	rewind(stdin);
	while (selection > 4 || selection < 1	) {
		printf("Invalid option! Please enter again : ");
		scanf("%d", &selection);
		rewind(stdin);
	}
	return selection;
}
void addOrder(char sName[]) {
	FILE *fOr;//handle one order
	FILE *fOrder;//save order by order
	FILE *fp;//read price and name
	FILE *fMember;// read member ID
	Order o = { 0 };
	Food f[30] = { 0 };
	Member mem[30] = {0};
	SYSTEMTIME t;
	GetSystemTime(&t);

	int orNum, fNum;
	char orId[6];
	fOr = fopen("order.dat", "rb");
	if (fOr == NULL) {
		o.orNum = 1001;
		fOr = fopen("order.dat", "ab");
		fclose(fOr);
	}
	else
		while (fread(&o, sizeof(Order), 1, fOr) != 0) {}//read last order ID
	fclose(fOr);
	o.d.day = t.wDay; 	o.d.month = t.wMonth; o.d.year = t.wYear; o.d.hour = t.wHour; o.d.min = t.wMinute;//generate date and time

	int i = 0, itemCount = 0, countMenu = 0, countMember = 0, found = 0;
	int m = 0;//modify condition
	int memYN = 0, endYN, noEndOrder, cancelYN, modiYN, memNum;
	double total = 0;
	int item;//total item without quantity = 0
	strcpy(o.sName, sName);
	
	fp = fopen("food.bin", "rb");
	while (fread(&f[countMenu], sizeof(Food), 1, fp) != 0)
		countMenu++;//indicate how many records in the file
	fclose(fp);
	fMember = fopen("member.txt", "r");
	while (fscanf(fMember, "%[^\:]:%[^\:]:%d:%c\n", &mem[countMember].memberID, &mem[countMember].name, &mem[countMember].contactNumber, &mem[countMember].gender) != EOF)
		countMember++;
	fclose(fMember);

	printf("Member? 1.Yes\t2.No : ");
	rewind(stdin);
	scanf("%d", &memYN);
	rewind(stdin);
	memYN = validation(memYN);
	if (memYN == 1) {
		printf("\nEnter member ID : M");
		do {
			found = 0;
			scanf("%4d", &memNum);
			rewind(stdin);
			sprintf(o.mId, "%c%d", 'M', memNum);
			for (i = 0; i < countMember; i++)
				if (strcmp(o.mId, mem[i].memberID) == 0)
					found = 1;
			if (!found)
				printf("Invalid Member ID! Please enter again : M");
		} while (!found);
	}
	else
		strcpy(o.mId, "-");
	system("cls");
	sprintf(o.oId, "%c%d", 'O', o.orNum);
	printf("Order ID : %s", o.oId);
	o.orNum++;
	printf("\nPress 0 to stop\n");
	do {
		do {
			found = 0;
			printf("\nItem %d\n", itemCount + 1);
			printf("Food ID  : F");
			scanf("%4d", &fNum);
			rewind(stdin);
			if (fNum == 0)
				break;
			sprintf(o.f[itemCount].fId, "%c%d", 'F', fNum);
			for (i = 0; i < countMenu; i++)
				if (strcmp(o.f[itemCount].fId, f[i].id) == 0) {
					found = 1;
					o.f[itemCount].price = f[i].price;
					strcpy(o.f[itemCount].name, f[i].name);
					break;
				}
			if (!found)
				printf("\nInvalid option! Please enter again : ");
			else {
				printf("Quantity : ");
				scanf("%d", &o.f[itemCount].qty);
				rewind(stdin);
				printf("\n");
				o.f[itemCount].amt = o.f[itemCount].price * o.f[itemCount].qty;
				total += o.f[itemCount].amt;
				o.tPrice = total;
				itemCount++;
			}
		} while (fNum != 0);
		item = 0;//renew item count;
		for (i = 0; i < itemCount; i++)// shift all quantity != 0 to end of list
			if (o.f[i].qty != 0) {
				o.f[item] = o.f[i];
				item++;
			}
		for (i = item; i < SIZE; i++)//assign empty struct to quantity = 0
			o.f[i] = o.f[SIZE - 1];
		fOr = fopen("temp.dat", "wb");//save one set of order in temporary file 
		fwrite(&o, sizeof(Order), 1, fOr);
		fclose(fOr);
		system("cls");
		displayOneOrder();//display order
		do {
			printf("\nSure end order? 1.Yes\t2.No : ");
			scanf("%d", &endYN);
			rewind(stdin);
			endYN = validation(endYN);
			if (endYN == 1 && cancelYN != 1) {
				fOrder = fopen("Order.dat", "ab");
				fwrite(&o, sizeof(Order), 1, fOrder);
				fclose(fOrder);
				system("cls");
				addPayment();
			}
			else if (endYN == 2) {
				printf("\n1. Modify Order\n2. Cancel Order\n3. Continue\n\nPlease enter your choice: ");
				scanf("%d", &noEndOrder);
				rewind(stdin);
				while (noEndOrder != 1 && noEndOrder != 2 && noEndOrder != 3)
				{
					printf("Invalid option! Please enter again : ");
					scanf("%d", &noEndOrder);
					rewind(stdin);
				}
				m = 0;
				switch (noEndOrder) {
				case 1:
					modify();
					m = 1;//condition for modify
					break;
				case 2:
					printf("Sure Cancel Order? 1.Yes\t2.No : ");
					scanf("%d", &cancelYN);
					rewind(stdin);
					cancelYN = validation(cancelYN);
					if (cancelYN == 1)
						system("del temp.dat");
					break;
				case 3:
					fOr = fopen("temp.dat", "rb");
					fread(&o, sizeof(Order), 1, fOr);
					fclose(fOr);
					break;
				}
			}
			if (cancelYN == 1)
				break;
			else
				displayOneOrder();
		} while (m && endYN != 1);
	} while (endYN != 1 && cancelYN != 1);
}
void searchOrder() {//search by member id and date
	FILE *fOrder;
	Order search[SIZE] = { 0 };
	int i = 0, j = 0, found = 0, countOrder = 0, temp, count = 0;
	int selection, day, month, year;
	char oID[6], mID[6], oNum[5], mNum[5];
	int searchYN;
	fOrder = fopen("Order.dat", "rb");
	while (fread(&search[countOrder], sizeof(Order), 1, fOrder))
		countOrder++;
	fclose(fOrder);
	do {
		found = 0;
		count = 0;//reset count
		strcpy(mID, "M");
		printf("1. Member ID\n2. Date (Month/Year)\n\nPlease enter your choice  : ");
		scanf("%d", &selection);
		rewind(stdin);
		selection = validation(selection);
		system("cls");
		switch (selection) {
		case 1:
			printf("Search\n======\nMember ID : M");
			scanf("%4s", &mNum);
			rewind(stdin);
			strcat(mID, mNum);
			for (i = 0; i < countOrder; i++)
				if (strcmp(search[i].mId, mID) == 0) {
					temp = i;
					if (displayOrder(1, temp, &found) == 1)
						count++;
				}
			if (found)
				printf("Member %s order %d time(s)\n", mID, count);
			break;
		case 2:
			printf("Search\n======\n1.Month\n2.Year\n\nPlease enter your choice : ");
			scanf("%d", &selection);
			rewind(stdin);
			selection = validation(selection);
			switch (selection) {
			case 1:
				printf("\nMonth : ");
				scanf("%d", &month);
				rewind(stdin);
				while (month > 12 || month < 1){
					printf("Invalid month! Please enter again : ");
					scanf("%d", &month);
					rewind(stdin);
				}
				for (i = 0; i < countOrder; i++)
					if (month == search[i].d.month) {
						temp = i;
						if (displayOrder(1, temp, &found) == 1)
							count++;
					}
				if (found)
					printf("%d order(s) in the month of %d\n", count, month);
				break;
			case 2:
				printf("\nYear : ");
				scanf("%d", &year);
				rewind(stdin);
				for (i = 0; i < countOrder; i++)
					if (year == search[i].d.year) {
						temp = i;
						if (displayOrder(1, temp, &found) == 1)
							count++;
					}
				if (found)
					printf("%d order(s) in the year of %d\n", count, year);
			}
		}
		if (!found)
			printf("Cannot be searched!\n");
		printf("\nAnymore to be search? 1.Yes\t2.No :");
		scanf("%d", &searchYN);
		rewind(stdin);
		searchYN = validation(searchYN);
		system("cls");
	} while (searchYN != 2);
}
void modify() {
	FILE *fOr;
	Order o;
	int i, found, quantity, modiYN, selection;
	char fID[6];
	int fNum, item, count;
	double amt;//original amount before modify
	do {
		count = 0;
		fOr = fopen("temp.dat", "rb");
		fread(&o, sizeof(Order), 1, fOr);
		fclose(fOr);
		for (i = 0; i < SIZE; i++)
			if (o.f[i].qty > 0)
				count++;
		system("cls");
		displayOneOrder();
		printf("\nQuantity : 0 to delete item\n");
		printf("====================================\n");
		printf("Food ID  : F");
		do {
			found = 0;
			scanf("%4d", &fNum);
			rewind(stdin);
			sprintf(fID, "%c%d", 'F', fNum);
			for (i = 0; i < count; i++)
				if (strcmp(o.f[i].fId, fID) == 0) {
					found = 1;
					amt = o.f[i].amt;
					break;
				}
			if (found == 0)
				printf("Invalid ID! Please enter again : F");
		} while (found == 0);
		printf("Modified Quantity : ");
		scanf("%d", &quantity);
		rewind(stdin);
		printf("\nSure to modify? 1.Yes\t2.No : ");
		scanf("%d", &modiYN);
		rewind(stdin);
		modiYN = validation(modiYN);
		item = 0; // item with quantity != 0
		if (modiYN == 1) {
			o.f[i].qty = quantity;
			o.f[i].amt = o.f[i].price * quantity;//recalculate amt and tPrice
			o.tPrice = o.tPrice - amt + o.f[i].amt;
			for (i = 0; i < count; i++)// shift all quantity != 0 to end of list
				if (o.f[i].qty != 0) {
					o.f[item] = o.f[i];
					item++;
				}
			for (i = item; i < SIZE; i++)//assign empty struct to quantity = 0 data 
				o.f[i] = o.f[SIZE - 1];
			fOr = fopen("temp.dat", "wb");
			fwrite(&o, sizeof(Order), 1, fOr);
			fclose(fOr);
			system("cls");
			displayOneOrder();
		}
		if (item > 0){
			printf("\nAnymore to be modify? 1.Yes\t2.No : ");
			scanf("%d", &selection);
			rewind(stdin);
			selection = validation(selection);
		}
		else
			break;
	} while (selection != 2);
	system("cls");
}
void displayOneOrder() {//display one order
	FILE *fOr;
	Order o;
	int i=0, count = 0;
	system("cls");
	printf("Ordering...\n===========\n");
	printf("%-7s%-20s%-5s%-8s%-10s\n", "Code", "Item", "Qty", "Unit", "Total", "----", "----", "---", "----", "-----");
	fOr = fopen("temp.dat", "rb");
	fread(&o, sizeof(Order), 1, fOr);
	fclose(fOr);
	for (i = 0; i < SIZE; i++)
		if (o.f[i].qty > 0) 
			count++;
	for (i = 0; i < count; i++)
		printf("%-7s%-20s%-5d%-8.2f%-10.2f\n", o.f[i].fId, o.f[i].name, o.f[i].qty, o.f[i].price, o.f[i].amt);
		printf("\nTotal Price : RM %.2f\n", o.tPrice);

}
int displayOrder(int search, int temp, int *found) {// display all order/ searched order
	FILE *fOrder;
	Order arrO[SIZE] = { 0 };
	int i = 0, j = 0, countOrder = 0;

	fOrder = fopen("Order.dat", "rb");
		while (fread(&arrO[countOrder], sizeof(Order), 1, fOrder) != 0)//copy all order into arr of struct
		countOrder++;
	fclose(fOrder);
	*found = 1;
	for (i = 0; i < countOrder; i++) {
		switch (search) {
		case 1:
			i = temp;
		default:
			printf("\n%s as at - %02d-%02d-%02d %02d:%02d\n", arrO[i].oId, arrO[i].d.day, arrO[i].d.month, arrO[i].d.year, arrO[i].d.hour, arrO[i].d.min);
			printf("Member :  %s\n\n", arrO[i].mId);
			printf("%-7s%-20s%-5s%-8s%-10s\n", "Code", "Item", "Qty", "Unit", "Total", "----", "----", "---", "----", "-----");
			for (j = 0; j < SIZE && arrO[i].f[j].qty != 0; j++) {
				printf("%-7s%-20s%-5d%-8.2f%-10.2f\n", arrO[i].f[j].fId, arrO[i].f[j].name, arrO[i].f[j].qty, arrO[i].f[j].price, arrO[i].f[j].amt);
			}
			printf("\n<%d food(s) ordered>\tTotal Price : RM %.2f\n", j, arrO[i].tPrice);
			printf("\n===============================================\n");
			break;
		}
		if (search)
			break;
	}
	if (!search)
		printf("<%d order(s)>\n", i);
	return 1;
}
int validation(int input) {
	while (input != 1 && input != 2) {
		printf("Invalid option! Please enter again : ");
		scanf("%d", &input);
		rewind(stdin);
	}
	return input;
}
