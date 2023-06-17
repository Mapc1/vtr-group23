#version 460

uniform mat4 m_pvm;
uniform vec4 cam_pos;
uniform mat3 m_normal;
uniform mat4 m_model;

in vec4 position;
in vec3 normal;

out vec4 n;

layout(std430, binding=1) buffer result {
    vec3 normals[];
};


void main(){

    n = normalize(m_model * vec4(normal,0));

    vec3 vec2Center = position.xyz; // Center is in (0,0,0)
    vec4 new_pos = position;
    
    for (int i = 0; i < 1000; i++) {
        float a = dot(vec2Center, normals[i]); // FIXME: Change variable name
        if (a > 0) {
            new_pos += vec4(normal,0) * 2.5e-4;
        } else {
            new_pos -= vec4(normal,0) * 2.5e-4;
        }
    }
    gl_Position = m_pvm * new_pos;
} 