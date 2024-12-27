(defun insert-functional (element sorted-list)
  (cond
    ((null sorted-list) (list element))
    ((<= element (car sorted-list)) (cons element sorted-list))
    (t (cons (car sorted-list) (insert-functional element (cdr sorted-list))))))

(defun insert-sort-functional (unsorted-list)
  (if (null unsorted-list)
      nil
      (insert-functional (car unsorted-list) (insert-sort-functional (cdr unsorted-list)))))

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
         (unsorted-list-copy (copy-list unsorted-list))) ; Копія вхідного списку
    (dolist (element unsorted-list-copy)
      (insert-imperative element sorted-vector current-length)
      (incf current-length))
    (subseq sorted-vector 0 current-length)))


(defun check-insertion-functional (test-name input expected)
  "Execute functional insert-sort function on input, compare result with expected and print comparison status"
  (let ((result (insert-sort-functional input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            test-name expected result)))

(defun check-insertion-functional (test-name input expected)
  "Execute functional insert-sort function on input, compare result with expected and print comparison status"
  (let ((result (insert-sort-functional input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            test-name expected result)))

(defun test-insertion-functional ()
  (format t "Start testing functional insert-sort function~%")
  (check-insertion-functional "test 1" '(100 50 20 10 5 1 0) '(0 1 5 10 20 50 100))
  (check-insertion-functional "test 2" '(15 42 8 -3 0 23 7 5 1) '(-3 0 1 5 7 8 15 23 42))
  (check-insertion-functional "test 3" '(3 14 159 26 535 897) '(3 14 26 159 535 897))
  (format t "End~%"))

(defun check-insertion-imperative (test-name input expected)
  "Execute imperative insert-sort function on input, compare result with expected and print comparison status"
  (let ((result (insert-sort-imperative input)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equalp result expected)
            test-name expected result)))

(defun test-insertion-imperative ()
  (format t "Start testing imperative insert-sort function~%")
  (check-insertion-imperative "test 1" '(100 50 20 10 5 1 0) '#(0 1 5 10 20 50 100))
  (check-insertion-imperative "test 2" '(15 42 8 -3 0 23 7 5 1) '#(-3 0 1 5 7 8 15 23 42))
  (check-insertion-imperative "test 3" '(3 14 159 26 535 897) '#(3 14 26 159 535 897))
  (format t "End~%"))



(test-insertion-functional)
(test-insertion-imperative)
