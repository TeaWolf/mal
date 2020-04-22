(ns step0-repl.core
  (:gen-class))


(defn mal-read [])

(defn mal-eval [input]
  input)

(defn prompt []
  (print "user> ")
  (flush)
  (read-line))

(defn -main
  "Run our little repl"
  [& args]
  (loop []
    (let [user-input  (prompt)]
      (println user-input)
      (recur))))
