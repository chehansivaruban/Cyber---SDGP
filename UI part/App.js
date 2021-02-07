import { StatusBar } from 'expo-status-bar';
import React,{createContext} from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";

import Home from './screens/Home'
import Home2 from './screens/Home2'
import Map from './screens/Map'


export const AuthContext = createContext();
const Stack = createStackNavigator();

const App = () => {

 
  const MainStackScreen = () => {
    return(
      <Stack.Navigator>
        {/* <Stack.Screen name = "Home" component ={Home}/>
         <Stack.Screen name = "Home2" component ={Home2}/> */}
        <Stack.Screen name = "Map" component ={Map}/> 
      </Stack.Navigator>
    )
  }
  
  return(
    <AuthContext.Provider value = { {name: 'Dave', age:21}}>
      <NavigationContainer>
        <MainStackScreen/>
      </NavigationContainer>
    </AuthContext.Provider>
  )
}



export default App;
