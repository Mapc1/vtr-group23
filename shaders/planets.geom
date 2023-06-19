#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;

in Data{
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn[3];

out Data{
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataOut;

void main(){
    for(int i = 0; i < 3; i++){
        gl_Position = gl_in[i].gl_Position;
        DataOut.n = DataIn[i].n;
        DataOut.l_dir = DataIn[i].l_dir;
        DataOut.eye = DataIn[i].eye;

        EmitVertex();
    }
    EndPrimitive();
}