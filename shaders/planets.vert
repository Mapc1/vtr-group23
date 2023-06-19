uniform mat4 m_view;

uniform vec4 l_dir; 

in vec4 position;
in vec3 normal;

out Data {
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataOut;

float cnoise(vec4 p);

void main(){
    DataOut.l_dir = vec3(m_view * -(l_dir));
    DataOut.n = normal;

    gl_Position = position;
} 