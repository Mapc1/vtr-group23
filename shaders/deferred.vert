uniform mat4 m_pvm;
uniform mat4 m_vm;

in vec4 position;
in vec3 normal;

out vec4 nn;
out vec4 pos;

void main() {
    nn = vec4(normal,0);    
    pos = position;
}
