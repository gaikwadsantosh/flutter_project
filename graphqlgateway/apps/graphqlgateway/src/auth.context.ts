import { UnauthorizedException } from "@nestjs/common";

export const authContext = ({req}) => {
    if(req.headers?.authorization){
        //validate jwt
        // right now return dummy user object
        return { user: {id: '1'}};
    }else{
        //if no authorization header, then throw exception
        throw new UnauthorizedException();
    }
}