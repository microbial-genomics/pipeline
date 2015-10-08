seq_count
seq_histogram <- hist(seq_count,breaks=15)
summary(seq_histogram)
box <- boxplot(seq_count,main="Sequence Counts Box Plot", ylab="Sequence Count")
summary(seq_count)
median(seq_count)

