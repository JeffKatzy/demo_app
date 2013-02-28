
# Table name: users
#  name        :string(255)
#  email       :string(255)
#  cell_number :string(255)
#  lecture_id  :integer
#  question_id :integer

# Table name: user_answers
#  question_id     :integer
#  user_id         :integer
#  value           :integer
#  correct         :boolean
#  user_lecture_id :integer

# Table name: user_lectures
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer

# Lesson
#  name        :string(255)
#  description :text

# Lecture
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer

# Table name: questions
#  id                           :integer          not null, primary key
#  lesson_id                    :integer
#  name                         :string(255)
#  description                  :text
#  answer                       :integer
#  lecture_id                   :integer

User.delete_all
UserAnswer.delete_all
UserLecture.delete_all


q1 = Question.create(name: "What is five plus five", description: "press 1 for 10", answer: 1)
q2 = Question.create(name: "What is 5 times 5", description: "press 2 for 25", answer: 2)
q3 = Question.create(name: "What is 20 minus 5", description: "Press three for fifteen", answer: 3)
q4 = Question.create(name: "What is 10 plus 10", description: "Press 4 for 20", answer: 4)
q5 = Question.create(name: "What is 6 times 5", description: "Press 5 for 30", answer: 5)

u1 = User.create(name: "Matty", email: "Matty@gmail.com", cell_number: "2153648143" )
u2 = User.create(name: "Stephen", email: "Stephen@gmail.com", cell_number: "2154997415")
u3 = User.create(name: "Adi", email: "Adi@gmail.com", cell_number: "2154997415")

less1 = Lesson.create(name: "Perimeter", description: "Lesson on perimeter")
less2 = Lesson.create(name: "Area", description: "Lesson on area.")

lec1 = Lecture.create(name: "Rectangle Perimeter", description: "length plus width times two")
lec2 = Lecture.create(name: "Circle Perimeter", description: "Pi times diameter")
lec3 = Lecture.create(name: "Pentagon Perimeter", description: "length of side times five")
lec4 = Lecture.create(name: "Rectangle Area", description: "length times width")
lec5 = Lecture.create(name: "Circle Area", description: "Pi radius squared")
lec6 = Lecture.create(name: "Pentagon Area", description: "length times width")

lec1.lesson = less1
lec2.lesson = less1
lec3.lesson = less1
lec4.lesson = less2
lec5.lesson = less2
lec6.lesson = less2

q1.lecture = lec1
q1.lesson = less1
q2.lecture = lec2
q2.lesson = less1
q3.lecture = lec3
q3.lesson = less1
q4.lecture = lec4
q4.lesson = less2
q5.lecture = lec5
q5.lesson = less2

ul1 = UserLecture.create(lecture_id: 1)
ul2 = UserLecture.create(lecture_id: 1)
ul3 = UserLecture.create(lecture_id: 1)
ul4 = UserLecture.create(lecture_id: 2)
ul5 = UserLecture.create(lecture_id: 2)
ul6 = UserLecture.create(lecture_id: 2, user_id: 3)

ul1.user = u1
ul2.user = u2
ul3.user = u3
ul4.user = u4
ul5.user = u5
ul6.user = u6

ans1 = UswerAnswer.create(question_id: 1, value: 1, user_lecture_id: 1)
ans2 = UswerAnswer.create(question_id: 2, value: 3, user_lecture_id: 1)
ans3 = UswerAnswer.create(question_id: 3, value: 2, user_lecture_id: 2)
ans4 = UswerAnswer.create(question_id: 4, value: 4, user_lecture_id: 2)
ans5 = UswerAnswer.create(question_id: 5, value: 5, user_lecture_id: 3)

ans1.user = u1
ans2.user = u1
ans3.user = u1
ans4.user = u1
ans5.user = u1

ans6 = UswerAnswer.create(user_id: 2, question_id: 1, value: 5, user_lecture_id: 1)
ans7 = UswerAnswer.create(user_id: 2, question_id: 2, value: 1, user_lecture_id: 1)
ans8 = UswerAnswer.create(user_id: 2, question_id: 3, value: 3, user_lecture_id: 2)
ans9 = UswerAnswer.create(user_id: 2, question_id: 4, value: 4, user_lecture_id: 2)
ans10 = UswerAnswer.create(user_id: 2, question_id: 5, value: 5, user_lecture_id: 3)

ans6.user = u2
ans7.user = u2
ans8.user = u2
ans9.user = u2
ans10.user = u2

ans11 = UswerAnswer.create(user_id: 3, question_id: 1, value: 1, user_lecture_id: 1)
ans12 = UswerAnswer.create(user_id: 3, question_id: 2, value: 2, user_lecture_id: 1)
ans13 = UswerAnswer.create(user_id: 3, question_id: 3, value: 3, user_lecture_id: 2)
ans14 = UswerAnswer.create(user_id: 3, question_id: 4, value: 4, user_lecture_id: 2)
ans15 = UswerAnswer.create(user_id: 3, question_id: 5, value: 1, user_lecture_id: 3)

ans11.user = u3
ans12.user = u3
ans13.user = u3
ans14.user = u3
ans15.user = u3

cl1 = Classroom.create(teacher_id: 1, name: "Physics", number: 777)
t1 = Teacher.create(name: "Mrs. Katz", email: "ruthiteach@gmail.com", password: "tryit", password_confirmation: "tryit")


cl1.users = [u1, u2, u3]







