# frozen_string_literal: true

categories = Category.create!([{ title: 'DevOps' },
                               { title: 'Frontend' }])
tests = Test.create!([{ title: 'Docker', category_id: categories[0].id },
                      { title: 'Kubernetes', category_id: categories[0].id },
                      { title: 'HTML', category_id: categories[1].id }])
questions = Question.create!([{ body: 'What is it Docker?', test_id: tests[0].id },
                              { body: 'How docker run?', test_id: tests[0].id },
                              { body: 'Where docker save volumes?', test_id: tests[0].id }])
answers = Answer.create!([{ question_id: questions[0].id,
                            answer: 'Docker is an open platform for developing, shipping, 
  and running applications',
                            correct: true },
                          { question_id: questions[0].id,
                            answer: 'Docker is a tool that was developed to help 
  define and share multi-container applications',
                            correct: false },
                          { question_id: questions[1].id,
                            answer: 'docker run',
                            correct: true },
                          { question_id: questions[1].id,
                            answer: 'docker start',
                            correct: false },
                          { question_id: questions[2].id,
                            answer: 'Volumes are stored in a part of the host filesystem
   which is managed by Docker( /var/lib/docker/volumes/ on Linux).',
                            correct: true },
                          { question_id: questions[2].id,
                            answer: 'Docker stores its on-disk time series data under 
  the directory specified by the flag storage. local. path .
  The default path is ./data (relative to the working directory), which is good to try 
  something out quickly but most likely not what you want for actual operations.',
                            correct: false }])
