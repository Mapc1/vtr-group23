#version 460

uniform mat4 m_pvm;
uniform vec4 cam_pos;
uniform mat3 m_normal;
uniform mat4 m_model;

in vec4 position;
in vec3 normal;

out vec4 n;


void main(){

    n = normalize(m_model * vec4(normal,0));
    
    gl_Position = m_pvm * position;
} 