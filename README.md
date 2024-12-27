<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right">Студент: Левчук Іван Володимирович група КВ-12<p>
<p align="right">Рік: 2024<p>

## Загальне завдання	
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів). 

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту наведені в п. 3.2. 
Кожна реалізована функція має бути протестована для різних тестових наборів. 
Тести мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).

## Варіант 14(6)
Алгоритм сортування вставкою №1 (з лінійним пошуком зліва) за незменшенням.

## Лістинг функції insert-functional

```lisp
(defun insert-functional (element sorted-list)
  (cond
    ((null sorted-list) (list element))
    ((<= element (car sorted-list)) (cons element sorted-list))
    (t (cons (car sorted-list) (insert-functional element (cdr sorted-list))))))

(defun insert-sort-functional (unsorted-list)
  (if (null unsorted-list)
      nil
      (insert-functional (car unsorted-list) (insert-sort-functional (cdr unsorted-list)))))

```

## Лістинг функції insert-imperative

```lisp
(defun insert-imperative (element sorted-vector vector-length)
  (let ((i 0))
    (loop while (< i vector-length)
          while (< (aref sorted-vector i) element)
          do (incf i))
    (loop for j from (1- vector-length) downto i
          do (setf (aref sorted-vector (1+ j)) (aref sorted-vector j)))
    (setf (aref sorted-vector i) element))

(defun insert-sort-imperative (unsorted-list)
  (let* ((list-length (length unsorted-list))
         (sorted-vector (make-array list-length :initial-element nil))
         (current-length 0)
         (unsorted-list-copy (copy-list unsorted-list)))
    (dolist (element unsorted-list-copy)
      (insert-imperative element sorted-vector current-length)
      (incf current-length))
    (subseq sorted-vector 0 current-length)))

```

## Тестові набори для insertion-functional

```lisp
(defun check-insertion-functional (test-name input expected)
  "Execute functional insert-sort function on input, compare result with expected and print comparison status"
  (let ((result (insert-sort-functional input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            test-name expected result)))

(defun test-insertion-functional ()
  (format t "Start testing functional insert-sort function~%")
  (check-insertion-functional "test 1" '(346 23 0 32 44 76 2 120 34 32 65) '(0 2 23 32 32 34 44 65 76 120 346))
  (check-insertion-functional "test 2" '(0 0 2 56 78 21 34 90 6751 1 1 1 -1 1) '(-1 0 0 1 1 1 1 2 21 34 56 78 90 6751))
  (check-insertion-functional "test 3" '(3 4 2 9 34) '(2 3 4 9 34))
  (format t "End~%"))
```
## Тестові набори для insertion-imperative

```lisp
(defun check-insertion-imperative (test-name input expected)
  "Execute imperative insert-sort function on input, compare result with expected and print comparison status"
  (let ((result (insert-sort-imperative input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            test-name expected result)))

(defun test-insertion-imperative ()
  (format t "Start testing imperative insert-sort function~%")
  (check-insertion-imperative "test 1" '(346 23 0 32 44 76 2 120 34 32 65) '(0 2 23 32 32 34 44 65 76 120 346))
  (check-insertion-imperative "test 2" '(0 0 2 56 78 21 34 90 6751 1 1 1 -1 1) '(-1 0 0 1 1 1 1 2 21 34 56 78 90 6751))
  (check-insertion-imperative "test 3" '(3 4 2 9 34) '(2 3 4 9 34))
  (format t "End~%"))
```

### Тестування
```lisp
Start testing functional insert-sort function
test 1 passed! Expected: (0 2 23 32 32 34 44 65 76 120 346) Obtained: (0 2 23 32 32 34 44 65 76 120 346)
test 2 passed! Expected: (-1 0 0 1 1 1 1 2 21 34 56 78 90 6751) Obtained: (-1 0 0 1 1 1 1 2 21 34 56 78 90 6751)
test 3 passed! Expected: (2 3 4 9 34) Obtained: (2 3 4 9 34)
End
Start testing imperative insert-sort function
test 1 failed! Expected: (0 2 23 32 32 34 44 65 76 120 346) Obtained: #(0 2 23 32 32 34 44 65 76 120 346)
test 2 failed! Expected: (-1 0 0 1 1 1 1 2 21 34 56 78 90 6751) Obtained: #(-1 0 0 1 1 1 1 2 21 34 56 78 90 6751)
test 3 failed! Expected: (2 3 4 9 34) Obtained: #(2 3 4 9 34)
End
```
