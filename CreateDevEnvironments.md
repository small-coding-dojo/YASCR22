# considerations for all the developer machines

## git access
- We will use one single github-user
- Differentiation between machines will be done via

```
git config --global user.name 
git config --global user.email
```

## Genaral approach to configuring the environments

1. Build container
   1. if neccessary install required software via docker run
   2. upload bootstrap script 
3. upload container
4. start container
5. 'ssh' into container to set up environment
   1. set up git information (see above)
7. 
