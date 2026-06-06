from pathlib import Path

Path.home()

for foo in [1,2,3,4]:
    for bar in foo.bit_count():
        print(bar)

