import React,{useContext} from 'react';
import { StyleSheet, Text, View ,Button} from 'react-native';
//import {AuthContext} from '../App'

const Home2 = (props) => {
    console.log(props.route.params);
    //const data = useContext(AuthContext);
    //console.log(data);
    return (
        <View style={styles.container}>
            <Text>
                Home Page 2.
            </Text>
            <Button title='Go Back' onPress ={()=>{props.navigation.navigate('Home')}}></Button>
            {/* <Button title='Back' onPress ={()=>{props.navigation.pop()}}></Button> */}
            {/* <Button title='Back 2' onPress ={()=>{props.navigation.goBack()}}></Button> */}
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: '#fff',
      alignItems: 'center',
      justifyContent: 'center',
    },
  });
  
export default Home2;