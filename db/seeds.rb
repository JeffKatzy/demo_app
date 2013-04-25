
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
Teacher.delete_all
Classroom.delete_all

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
lec1.save
lec2.lesson = less1
lec2.save
lec3.lesson = less1
lec3.save
lec4.lesson = less2
lec4.save
lec5.lesson = less2
lec5.save
lec6.lesson = less2
lec6.save

q1.lecture = lec1
q1.save
q2.lecture = lec1
q2.save
q3.lecture = lec2
q3.save
q4.lecture = lec2
q4.save
q5.lecture = lec2
q5.save

u1.lecture = lec1
u1.save
u2.lecture = lec1
u2.save
u3.lecture = lec2
u3.save

u1.question = q1
u1.save
u2.question = q2
u2.save
u3.question = q3
u3.save

ul1 = UserLecture.create
ul2 = UserLecture.create
ul3 = UserLecture.create
ul4 = UserLecture.create
ul5 = UserLecture.create
ul6 = UserLecture.create

ul1.lecture = lec1
ul2.lecture = lec1
ul3.lecture = lec1
ul4.lecture = lec2
ul5.lecture = lec2
ul6.lecture = lec2

ul1.user = u1
ul1.save
ul2.user = u2
ul2.save
ul3.user = u3
ul3.save
ul4.user = u1
ul4.save
ul5.user = u2
ul5.save
ul6.user = u3
ul6.save

ans1 = UserAnswer.create(value: 1)
ans2 = UserAnswer.create(value: 3)
ans3 = UserAnswer.create(value: 2)
ans4 = UserAnswer.create(value: 4)
ans5 = UserAnswer.create(value: 5)

ans1.question = q1
ans1.save
ans2.question = q2
ans2.save
ans3.question = q3
ans3.save
ans4.question = q4
ans4.save
ans5.question = q5
ans5.save

ans1.user = u1
ans1.save
ans2.user = u1
ans2.save
ans3.user = u1
ans3.save
ans4.user = u1
ans4.save
ans5.user = u1
ans5.save

ans1.user_lecture = ul1
ans1.save
ans2.user_lecture = ul1
ans2.save
ans3.user_lecture = ul4
ans3.save
ans4.user_lecture = ul4
ans4.save
ans5.user_lecture = ul4
ans5.save

ans6 = UserAnswer.create(value: 5)
ans7 = UserAnswer.create(value: 1)
ans8 = UserAnswer.create(value: 3)
ans9 = UserAnswer.create(value: 4)
ans10 = UserAnswer.create(value: 5)

ans6.question = q1
ans6.save
ans7.question = q2
ans7.save
ans8.question = q3
ans8.save
ans9.question = q4
ans9.save
ans10.question = q5
ans10.save

ans6.user_lecture = ul2
ans6.save
ans7.user_lecture = ul2
ans7.save
ans8.user_lecture = ul5
ans8.save
ans9.user_lecture = ul5
ans9.save
ans10.user_lecture = ul5
ans10.save

ans6.user = u2
ans6.save
ans7.user = u2
ans7.save
ans8.user = u2
ans8.save
ans9.user = u2
ans9.save
ans10.user = u2
ans10.save

ans11 = UserAnswer.create(value: 1)
ans12 = UserAnswer.create(value: 2)
ans13 = UserAnswer.create(value: 3)
ans14 = UserAnswer.create(value: 4)
ans15 = UserAnswer.create(value: 1)

ans11.question = q1
ans11.save
ans12.question = q2
ans12.save
ans13.question = q3
ans13.save
ans14.question = q4
ans14.save
ans15.question = q5
ans15.save

ans11.user = u3
ans11.save
ans12.user = u3
ans12.save
ans13.user = u3
ans13.save
ans14.user = u3
ans14.save
ans15.user = u3
ans15.save

ans11.user_lecture = ul3
ans11.save
ans12.user_lecture = ul3
ans12.save
ans13.user_lecture = ul6
ans13.save
ans14.user_lecture = ul6
ans14.save
ans15.user_lecture = ul6
ans15.save

cl1 = Classroom.create(name: "Physics", number: 777)
t1 = Teacher.create(name: "Mrs. Katz", email: "ruthiteach@gmail.com", password: "tryit", password_confirmation: "tryit")

cl1.teacher = t1
cl1.users = [u1, u2, u3]
cl1.save








