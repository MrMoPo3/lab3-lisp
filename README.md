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

## Лістинг функції insert-tail

```lisp
(defun insert-tail (x sorted-list)
  (cond
    ((null sorted-list) (list x))
    ((<= x (car sorted-list)) (cons x sorted-list))
    (t (cons (car sorted-list) (insert-tail x (cdr sorted-list))))))

(defun insertion-sort-tail (unsorted-list acc)
  (if (null unsorted-list)
      acc
      (insertion-sort-tail 
       (cdr unsorted-list)
       (insert-tail (car unsorted-list) acc))))

(defun insertion-sort (unsorted-list)
  (insertion-sort-tail unsorted-list nil))

```

## Лістинг функції insert-imperative

```lisp
(defun insert-imperative (x sorted-vector length)
  (let ((i 0))
    (loop while (< i length) 
          while (< (aref sorted-vector i) x) 
          do (incf i))
    (loop for j from (1- length) downto i
          do (setf (aref sorted-vector (1+ j)) (aref sorted-vector j)))
    (setf (aref sorted-vector i) x)))

(defun insertion-sort-imperative (unsorted-list)
  (let* ((length (length unsorted-list))
         (sorted-vector (make-array length :initial-element nil))
         (current-length 0))
    (dolist (x unsorted-list (subseq sorted-vector 0 current-length))
      (insert-imperative x sorted-vector current-length)
      (incf current-length))))
```

## Тестові набори для

```lisp

```
## Тестові набори для

```lisp

```

### Тестування
```lisp

```
