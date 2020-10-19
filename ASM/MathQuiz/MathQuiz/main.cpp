#include <iostream>
#include <iomanip>
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include <ctype.h> 
#pragma warning (disable:4996)
#define TOP_RANK 5
#define ARRAY_SIZE 20
using namespace std;
typedef struct {
	char username[30];
	int totalPlay;
	double totalScore;
	int accumulateScore;
}Ranking;

typedef struct {
	char username[30];
	char password[30];
}User;
bool file_exist(char *filename);
void sortByScore(Ranking r[], int count);
void strupp(char* beg);

extern "C" {
	// external ASM procedures:
	void MATH_QUIZ();

	// local C functions:
	void cls();
	int checkLogin(char * username, char * password);
	void checkRanking();
	void addRanking(char * user, int correctCount, int totalQuest, int level);
	int getRemainder(char *tmp);
}


// program entry point
int main()
{
	MATH_QUIZ();				// call ASM procedure
	return 0;
}

// Prompt the user for an integer. 

void cls()
{
	system("cls");
}
int str_compare(char *s1, char *s2)
{
	char tmp[30];
	strcpy(tmp, s1);
	strupp(tmp);
	strupp(s2);
	int i,ctrl = 0;
	if (strcmp(tmp,"") == 0|| strcmp(s2, "") ==0)
		ctrl = 1;
	else
		for (i = 0; i < strlen(s2); i++) {
				if (tmp[i] != s2[i] ){
					ctrl = 1;
					break;
				}
		}
	
	return ctrl;
}
int checkLogin(char * username, char * password) { 
	User u[20];
	FILE *fp;
	int i = 0, count = 0, ctrl = 0;	//return ctrl 1 as valid acc
	fp = fopen("user.txt", "r");
	//read from file and store into array of structure
	while (fscanf(fp, "%[^\:]:%[^\:]:\n", &u[i].username, &u[i].password) != EOF)
		i++;
	count = i;
	for(int i=0;i < count; i++){
		if ((str_compare(username, u[i].username) == 0) && (str_compare(password, u[i].password) == 0)) {
			ctrl = 1;
			break;
		}
	}
	fclose(fp);
	return ctrl;
}
void checkRanking() {
	int i = 0, count = 0;
	Ranking r[20];
	char fileName[] = "ranking.txt";
	FILE *fp;

	if ((fp = fopen(fileName, "r")) != NULL) {
		char line[1024];

		//read from file and store into array of structure
		while (fscanf(fp, "%[^\:]:%d:%lf:%d\n", &r[i].username, &r[i].totalPlay, &r[i].totalScore, &r[i].accumulateScore) != EOF)
			i++;
		fclose(fp);
		sortByScore(r, i);
	}
	else {
		printf("No file found!");
	}
}

void addRanking(char * user, int correctCount, int totalQuest, int level) {
	
	Ranking r[20];
	FILE *fp;
	int i = 0, count = 0;
	int accScore = 0;
	double score = 0;
	
	fp = fopen("ranking.txt", "r");

	//read from file and store into array of structure
	while (fscanf(fp, "%[^\:]:%d:%lf:%d\n", &r[i].username, &r[i].totalPlay, &r[i].totalScore, &r[i].accumulateScore) != EOF)
		i++;

	count = i;//indicate how many records in the file
	fclose(fp);
	score = ((double)correctCount / (double)totalQuest * 100);
	/*
	For accumulateScore:
	if the user score above 50%, accScore will be added
	beginner		- 1
	intermediate	- 3
	advanced		- 5
	*/
	if(score > 50)
		if (level == 1)
			accScore = 1;
		else if (level == 2)
			accScore = 3;
		else
			accScore = 5;
	for (i = 0; i < count; i++)
		if (strcmp(user, r[i].username) == 0) {
			r[i].totalPlay++;
			r[i].totalScore = r[i].totalScore + score;
			r[i].accumulateScore = r[i].accumulateScore + accScore;
			break;
		}

	//to save the modified records back to text file
	fp = fopen("ranking.txt", "w");
	for (i = 0; i < count; i++)
		fprintf(fp, "%s:%d:%.2f:%d\n", r[i].username, r[i].totalPlay, r[i].totalScore, r[i].accumulateScore);
	fclose(fp);
}

void sortByScore(Ranking r[], int count) {
	int i, j;
	Ranking tmp;
	int rowDisplay = 0;
	for (i = 0; i < count; ++i)
	{
		for (j = i + 1; j < count; ++j)
		{
			if (r[i].accumulateScore < r[j].accumulateScore)
			{
				tmp = r[i];
				r[i] = r[j];
				r[j] = tmp;
			}
		}
	}

	if (count < TOP_RANK) {
		rowDisplay = count;
	}
	else {
		rowDisplay = TOP_RANK;
	}

	printf("%-15s%-15s%-15s%-15s\n", "User", "Total Play", "Avg Score", "Accumulate Score");
	printf("%-15s%-15s%-15s%-15s\n", "-------------", "----------", "---------", "----------------");

	for (int i = 0; i < rowDisplay; i++) {
		double avg = (double)r[i].totalScore / (double)r[i].totalPlay;
		printf("%-15s%-15d%-15.2f%-15d\n", r[i].username, r[i].totalPlay, avg, r[i].accumulateScore);
	}
}

bool file_exist(char *filename)
{
	struct stat   buffer;
	return (stat(filename, &buffer) == 0);
}

int getRemainder(char *tmp) { //split user input to get remainder part
	int x = 0;
	int i = 0;
	int j = 0;
	char ch;
	bool validStr = true; //eg.validStr = 10R3 or 10r3

	strupp(tmp);
	for(int i =0;i<strlen(tmp);i++) //no valid if contain other alphabet except R
		if (isalpha(tmp[i]) && tmp[i] != 'R'){
			validStr = false;
			break;
		}
	if(tmp[strlen(tmp)] == 'R') //last value is R
		validStr = false;

	if(validStr)
		if (strchr(tmp, 'R') != NULL)
		{
			char *p = strtok(tmp, "R");
			char *array[2];
			while (p != NULL)
			{
				array[i++] = p;
				p = strtok(NULL, "R");
			}
			if(array[1])
			sscanf(array[1], "%d", &x);
		}
	return x;
}

void strupp(char* beg)
{
	while (*beg++ = toupper(*beg));
}