#version 410

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

//in gl_PerVertex // provenant du nuanceur de sommets
//{
//vec4 gl_Position;
//float gl_PointSize;
//float gl_ClipDistance[];
//} gl_in[];

//out gl_PerVertex
//{
//vec4 gl_Position;
//float gl_PointSize;
//float gl_ClipDistance[];
//};

in Attribs {
    vec4 couleur;
} AttribsIn[];

out Attribs {
    vec3 lumiDir;
    vec3 normale, obsVec;
    vec4 couleur;
    } AttribsOut;

vec3 GetNormal()
{
   vec3 a = vec3(gl_in[1].gl_Position) - vec3(gl_in[0].gl_Position);
   vec3 b = vec3(gl_in[2].gl_Position) - vec3(gl_in[0].gl_Position);
   return cross(a, b);
}  

void main()
{ 
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {   
        AttribsOut.normale = GetNormal();
        AttribsOut.lumiDir = vec3( 0, 0, 1 );
        AttribsOut.obsVec = vec3( 0, 0, 1 );
        gl_Position = gl_in[i].gl_Position;
        AttribsOut.couleur = AttribsIn[i].couleur;
        EmitVertex();
    }
    EndPrimitive();
}
