#version 460

uniform vec4 diffuse = vec4(1.0);
uniform float shine = 128;
uniform vec4 specular = vec4(2.0, 0.0, 0.0, 1.0);

in Data{
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn;

out vec4 color;

void main(){
    vec3 n = normalize(DataIn.n);
    vec3 l = normalize(DataIn.l_dir);
    vec3 e = vec3(normalize(DataIn.eye));

    float intensity = max(dot(n,l), 0.0);
    vec4 spec = vec4(0);
    vec4 d = diffuse;
    if (intensity > 0){
        vec3 h = normalize(DataIn.l_dir + e);
        
        float intSpec = max(dot(h,n), 0.0);

        spec = specular * pow(intSpec, shine);
    }

    if (DataIn.eye.y > -0.1) d = vec4(0.0, 1, 0, 1);

    color = (max(intensity, 0.25) * d) + spec;
}
