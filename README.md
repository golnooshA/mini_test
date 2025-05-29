# 🎥 Quiz Video Player App

A Flutter application that plays instructional videos and quizzes users on what they learned. Users
can browse video lessons, watch them with custom playback controls, and take interactive
multiple-choice quizzes with instant feedback.

---

## 🚀 Features

- **Quiz List**
    - Loads a JSON file (`assets/quizzes.json`) containing quiz metadata
    - Displays each quiz with title, image, video length, and number of questions
    - “Continue” button opens the video player

- **Custom Video Player**
    - Uses `video_player` package to play local asset `.mp4` files
    - Includes Play/Pause, rewind, fast-forward, and scrub progress slider
    - Uses a transparent AppBar with consistent back button placement

- **Interactive Quiz**
    - Multiple-choice interface built from JSON questions
    - Shows immediate visual feedback: ✅ green for correct, ❌ red for incorrect
    - Tracks progress and correctness

- **Result Screen**
    - Summary page after finishing the quiz
    - Shows a percentage score with a “DONE” check icon
    - Option to close and return to the list

---

## 📸 Screenshots

|    ![Quiz List](assets/screens/quiz_list.png)    | ![Video Player](assets/screens/video_player.png) |
|:------------------------------------------------:|:------------------------------------------------:|
|     ![Start Quiz](assets/screens/start.png)      |      ![Results](assets/screens/results.png)      |
| ![Quiz Correct](assets/screens/quiz-correct.png) | ![Quiz Incorrect](assets/screens/quiz_false.png) |



