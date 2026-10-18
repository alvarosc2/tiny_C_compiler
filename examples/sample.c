int count = 0;
char *msg = "hola";

int main() {
    int i = 0;
    while (i <= 10 && *(msg + i) != '\n') {
        if (i == 5) return i;
        else count = count + 1;
        i = i + 1;
    }
    return 0;
}
