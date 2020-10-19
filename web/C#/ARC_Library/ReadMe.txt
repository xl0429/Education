password of login user
----------------------
				Username	Password
user_admin		Admin1		password
user_member		Member1		password
user_staff		Staff1		password

Username (All username log with Password = password)
Member1 - active
Member2 - active but will be blocked, need to be activated
Member3 - blocked
Member4 - noActive


Main Operation
--------------
Anonymous user - view the book list
User_Member    - reserve a book
			   - account mgmt(reset pass, change profile)
			   
User_Staff     - CRUD Book Category, 
			   - CRUD Book,
			   - Borrow, Return (+penalty if exist)
			   - Activate blocked account
			   - Check loan list
			   - account mgmt(reset pass, change profile)

User_Admin     - (same as all in User_Staff)
			   - CRUD staff
			   - View Reports