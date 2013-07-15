Reductor
========

Collection of common map_reduce operations, implemented with mongoid. 
## Basic sample:

```
pry(main)>Project.all.reduct :sum do
pry(main)>  by :project_id, { created_at: :by_day }
pry(main)>  value :duration
pry(main)>end
=> {
                        nil => 12.0,
    2012-05-10 22:00:00 UTC => 1.0,
    2012-05-14 22:00:00 UTC => 1.0,
    2012-05-30 22:00:00 UTC => 1.0,
    2012-06-02 22:00:00 UTC => 2.0,
    2012-06-07 22:00:00 UTC => 2.0,
    2012-07-01 22:00:00 UTC => 1.0,
    2012-07-11 22:00:00 UTC => 1.0,
    2012-07-15 22:00:00 UTC => 1.0,
    2012-08-05 22:00:00 UTC => 1.0,
    2012-08-10 22:00:00 UTC => 1.0
}

```
