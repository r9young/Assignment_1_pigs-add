#!bin/dash

# As noted by Joshua in #746 

# the Reference Implementation was showing "untracked" when it probably shouldn't have been.

# After a quick investigation into what git was doing we (I) have decided to update the output from pigs-stastus in three situations.

# firstly:
# the deleted status has been updated to file deleted, deleted from index

# secondly:
# in some (but not all) situations untracked has been updated to deleted from index 

# thirdly:
# another case not covered in the provided tests has been modified slightly.


# The first and second case are tested by autotest so previously correct code will now fail 3 autotests. 

# the autotest output and playing with the Reference Implementation should provide enough information to update your previously correct code fairly easily.

# The third case is something for you to find in the Reference Implementation (and maybe write a test for it so that you can catch future changes)


https://edstem.org/au/courses/12028/discussion/1456791