import { qrdni } from 'qrdnicapacitor';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    qrdni.echo({ value: inputValue })
}
