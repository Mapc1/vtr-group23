#version 460

in vec4 n;

out vec4 color;

void main(){
    vec4 normal = normalize(n);
    color = normal;
}
