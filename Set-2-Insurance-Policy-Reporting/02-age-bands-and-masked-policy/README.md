# Question 2 – Policy age bands and masked policy numbers (DATEADD, DATEDIFF, CASE, string functions)

The policy number is masked with LEFT, REPLICATE and RIGHT (e.g. `HLT******0101`). CASE with DATEDIFF gives the policy age band, and DATEADD gives the renewal date. Expected: 17 active policies.

## Query files

- [policy_age_and_masking.sql](policy_age_and_masking.sql)

## Output

Full text output: [output.txt](output.txt)

![t2](policy_age_and_masking_output.png)


## Approach

![flowchart](flowchart.svg)
