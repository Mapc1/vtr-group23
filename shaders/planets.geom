uniform mat4 m_pvm;
uniform mat4 m_viewModel;
uniform mat3 m_normal;


layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;

in Data{
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn[3];

out Data{
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataOut;


void main(){
    
    /*
    vec4 vert1 = gl_in[0].gl_Position;
    vec4 vert2 = gl_in[1].gl_Position;
    vec4 vert3 = gl_in[2].gl_Position;
    vec4 vert4 = gl_in[3].gl_Position;
    vec4 vert5 = gl_in[4].gl_Position;
    vec4 vert6 = gl_in[5].gl_Position; 

    vec4 edge11 = vert3 - vert1;
    vec4 edge12 = vert2 - vert1;
    vec3 normal1 = normalize(cross(edge11.xyz, edge12.xyz));

    vec4 edge21 = vert5 - vert1;
    vec4 edge22 = vert3 - vert1;
    vec3 normal2 = normalize(cross(edge21.xyz, edge22.xyz));

    vec4 edge31 = vert5 - vert3;
    vec4 edge32 = vert4 - vert3;
    vec3 normal3 = normalize(cross(edge31.xyz, edge32.xyz));

    vec4 edge41 = vert5 - vert1;
    vec4 edge42 = vert6 - vert1;
    vec3 normal4 = normalize(cross(edge41.xyz, edge42.xyz));

    vec3 n1 = cross(cross(normal2,normal1), normal4);
    vec3 n3 = cross(cross(normal2,normal1), normal3);
    vec3 n5 = cross(cross(normal2,normal3), normal4);

    vec3 ns[3] = {n1,n3,n5};


    gl_Position = gl_in[0].gl_Position;

    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[0].old_pos;
    DataOut.n = normalize(m_normal * n1);
    DataOut.l_dir = DataIn[0].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);

    EmitVertex();

    gl_Position = gl_in[4].gl_Position;

    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[4].old_pos;
    DataOut.n = normalize(m_normal * n5);
    DataOut.l_dir = DataIn[4].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);

    EmitVertex();

    gl_Position = gl_in[2].gl_Position;

    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[2].old_pos;
    DataOut.n = normalize(m_normal * n3);
    DataOut.l_dir = DataIn[2].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);

    EmitVertex();
    EndPrimitive();
    */
    vec4 edge1 = gl_in[1].gl_Position - gl_in[0].gl_Position;
    vec4 edge2 = gl_in[2].gl_Position - gl_in[0].gl_Position;
    vec3 normal = normalize(cross(edge1.xyz, edge2.xyz));

    gl_Position = gl_in[0].gl_Position;

    DataOut.pos = DataIn[0].pos;
    DataOut.old_pos = DataIn[0].old_pos;
    DataOut.n = normal;//normalize(DataIn[0].n);
    DataOut.l_dir = DataIn[0].l_dir;
    DataOut.eye = DataIn[0].eye;

    /*DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[0].old_pos;
    DataOut.n = DataIn[0].n;;//normalize(m_normal * DataIn[0].n);
    DataOut.l_dir = DataIn[0].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);
*/
    EmitVertex();
/*
    gl_Position = gl_in[2].gl_Position;
    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[2].old_pos;
    DataOut.n = DataIn[2].n;
    DataOut.l_dir = DataIn[2].l_dir;
    DataOut.eye = DataIn[2].eye;
*/
    gl_Position = gl_in[1].gl_Position;
    DataOut.pos = DataIn[1].pos;
    DataOut.old_pos = DataIn[1].old_pos;
    DataOut.n = normal;//normalize(DataIn[1].n);
    DataOut.l_dir = DataIn[1].l_dir;
    DataOut.eye = DataIn[1].eye;

    EmitVertex();
/*
    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[1].old_pos;
    DataOut.n = DataIn[1].n;//normalize(m_normal * DataIn[4].n);
    DataOut.l_dir = DataIn[1].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);
*/
/*
    gl_Position = gl_in[4].gl_Position;
    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[4].old_pos;
    DataOut.n = DataIn[4].n;
    DataOut.l_dir = DataIn[4].l_dir;
    DataOut.eye = DataIn[4].eye;
*/
    gl_Position = gl_in[2].gl_Position;
    DataOut.pos = DataIn[2].pos;
    DataOut.old_pos = DataIn[2].old_pos;
    DataOut.n = normal;//normalize(DataIn[2].n);
    DataOut.l_dir = DataIn[2].l_dir;
    DataOut.eye = DataIn[2].eye;

    EmitVertex();
/*
    DataOut.pos = gl_Position;
    DataOut.old_pos = DataIn[2].old_pos;
    DataOut.n = DataIn[2].n;//normalize(m_normal * DataIn[2].n);
    DataOut.l_dir = DataIn[2].l_dir;
    DataOut.eye = -(m_viewModel * gl_Position);
*/
    EndPrimitive();

}