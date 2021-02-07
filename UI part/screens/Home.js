import React,{useState} from 'react';
import { StyleSheet, Text, View ,Button} from 'react-native';

const Home = (props) => {

    const [name, setName] = useState("hhh");
    let name2 = 'tharuka';
    return (
        <View style={styles.container}>
            <Text>
                Home Page.
                {name}.....{name2}
            </Text>
            {/* <Button title='Go to next page' onPress ={()=>{props.navigation.navigate('Home2',"Hello") }}></Button>  */}
            <Button title='Go to next page' onPress ={()=>{name2 = "jaya" ;setName("sss12345") }}></Button>
        </View>
    )
}

//push 


const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: '#fff',
      alignItems: 'center',
      justifyContent: 'center',
    },
  });
  
export default Home;